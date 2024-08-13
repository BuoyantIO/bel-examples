resource "kubernetes_namespace" "linkerd_buoyant" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "linkerd_buoyant" {
  name       = "linkerd-buoyant"
  namespace  = kubernetes_namespace.linkerd_buoyant.metadata[0].name
  repository = "https://helm.buoyant.cloud"
  chart      = "linkerd-buoyant"
  version    = "v0.31.0"

  set {
    name  = "metadata.agentName"
    value = "terraform-example"
  }

  set {
    name  = "api.clientID"
    value = var.api_client_id
  }

  set {
    name  = "api.clientSecret"
    value = var.api_client_secret
  }
}
