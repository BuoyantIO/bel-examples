resource "kubernetes_namespace" "linkerd" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_manifest" "buoyant-license" {
  manifest = yamldecode(file("${path.module}/linkerd-buoyant-enterprise-secret.yaml"))
}

resource "helm_release" "linkerd-crds" {
  name       = "linkerd-crds"
  namespace  = kubernetes_namespace.linkerd.metadata[0].name
  repository = "https://helm.buoyant.cloud"
  chart      = "linkerd-enterprise-crds"
  version    = "var.chart_version"
}

resource "helm_release" "linkerd-control-plane" {
  name       = "linkerd-control-plane"
  namespace  = kubernetes_namespace.linkerd.metadata[0].name
  repository = "https://helm.buoyant.cloud"
  chart      = "linkerd-enterprise-control-plane"
  version    = "var.chart_version"

  set {
    name  = "linkerd-control-plane.identity.externalCA"
    value = "true"
  }

  set {
    name  = "linkerd-control-plane.identity.issuer.scheme"
    value = "kubernetes.io/tls"
  }

  set {
    name  = "licenseSecret"
    value = "buoyant-license"
  }
  
    depends_on = [
    helm_release.linkerd-crds,
    kubernetes_manifest.buoyant-license
  ]
}
