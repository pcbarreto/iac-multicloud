provider "helm" {
  kubernetes {
    host = module.eks.cluster_endpoint
    # cluster_ca_certificate = base64decode(var.cluster_ca_cert)
    exec {
      api_version = "client.authentication.k8s.io/v1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}

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
