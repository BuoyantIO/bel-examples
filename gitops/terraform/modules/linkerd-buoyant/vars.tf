variable "namespace" {
  type        = string
  default     = "linkerd-buoyant"
  description = "Namespace for Buoyant's BEL and Buoyant Cloud component installation"
}

variable "api_client_id" {
  type        = string
  description = "API client ID for Buoyant Cloud"
}

variable "api_client_secret" {
  type        = string
  description = "API client secret for Buoyant Cloud"
}