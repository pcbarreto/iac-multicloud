variable "metrics_server_version" {
  description = "Version of the Metrics server Helm Chart"
  type        = string
    default = "3.12.2"
}


variable "kube_state_metrics_version" {
  description = "Version of the Metrics server Helm Chart"
  type        = string
  default = "5.33.1"
}
