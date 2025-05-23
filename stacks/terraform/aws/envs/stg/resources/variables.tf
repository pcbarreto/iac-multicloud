variable "metrics_server_version" {
  description = "Version of the Metrics server Helm Chart"
  type        = string
}

variable "metrics_server_namespace" {
  description = "Namespace of the Metrics server Install Helm Chart"
  type        = string
  default     = "kube-system"
}
variable "kube_state_metrics_version" {
  description = "Version of the Metrics server Helm Chart"
  type        = string
}