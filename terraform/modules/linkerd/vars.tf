variable "namespace" {
  type        = string
  default     = "linkerd"
  description = "Namespace for Buoyant's BEL and Buoyant Cloud component installation"
}

variable "chart_version" {
  type        = string
  default     = "2.15.4"
  description = "Version of the Helm chart to deploy"
}