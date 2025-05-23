resource "helm_release" "loki_stack" {
  name       = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = "2.10.2"
  namespace  = "monitoring"

  create_namespace = true
  set {
    name  = "prometheus.enabled"
    value = "true"
  }
  set {
    name  = "grafana.enabled"
    value = "true"
  }
}
