locals {
  namespaces = {
    linkerd         = var.namespace["linkerd"]
    linkerd-buoyant = var.namespace["linkerd-buoyant"]
    cert-manager    = var.namespace["cert-manager"]
  }
}

module "cert_manager" {
  source    = "../../modules/cert-manager"
  namespace = local.namespaces.cert-manager
}

module "linkerd" {
  source            = "../../modules/linkerd"
  namespace         = local.namespaces.linkerd
  chart_version           = "2.15.4"
}

module "linkerd_buoyant" {
  source            = "../../modules/linkerd-buoyant"
  namespace         = local.namespaces.linkerd-buoyant
  api_client_id     = var.api_client_id
  api_client_secret = var.api_client_secret
}


resource "null_resource" "apply_cert_manager_rbac" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/certs/cert-manager-rbac.yaml"
  }
}

resource "null_resource" "apply_linkerd_ca_trust_bundle" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/certs/linkerd-ca-trust-bundle.yaml"
  }
}

resource "null_resource" "apply_linkerd_issuers_certs" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/certs/linkerd-issuers-certs.yaml"
  }
}
