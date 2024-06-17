variable "namespace" {
  type = map(string)
  default = {
    linkerd         = "linkerd"
    linkerd-buoyant = "linkerd-buoyant"
    cert-manager    = "cert-manager"
  }
  description = "Namespaces for different components"
}

variable "api_client_id" {
  type        = string
  description = "API client ID for Buoyant Cloud"
  default     = "fQh-LCzxj3Qy7igE"
}

variable "api_client_secret" {
  type        = string
  description = "API client secret for Buoyant Cloud"
  default     = "4cbacba962056c614d7c0278462457b3eef0b4c88164cbba469575dc5a21a9ef"
}