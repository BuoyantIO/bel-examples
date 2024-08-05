provider "kubernetes" {
  config_path      = "~/.kube/config"
  config_context   = "terraform-example"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "terraform-example"
  }
}
