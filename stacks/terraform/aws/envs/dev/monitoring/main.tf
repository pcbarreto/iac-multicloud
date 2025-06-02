# Loki
resource "helm_release" "loki" {
  name             = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki"
  namespace        = "loki"
  create_namespace = true
  version          = "6.30.1"
}

# Tempo
resource "helm_release" "tempo" {
  name             = "tempo"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "tempo"
  namespace        = "tempo"
  create_namespace = true
  version          = "2.7.2"
}

# Mimir
resource "helm_release" "mimir" {
  name             = "mimir"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "mimir-distributed"
  namespace        = "mimir"
  create_namespace = true
  version          = "5.6.0"
}

# Grafana com datasources automáticos
resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = "grafana"
  create_namespace = true
  version          = "9.2.2"

  values = [
    templatefile("${path.module}/values.yaml", {
      loki_url   = "http://loki.loki.svc.cluster.local:3100"
      tempo_url  = "http://tempo.tempo.svc.cluster.local:3100"
      mimir_url  = "http://mimir.mimir.svc.cluster.local:9009/prometheus"
      admin_user = "admin"
      admin_pass = "ChangeMe123"
    })
  ]

  depends_on = [
    helm_release.loki,
    helm_release.tempo,
    helm_release.mimir
  ]
}

resource "kubernetes_ingress_v1" "grafana" {
  metadata {
    name      = "grafana"
    namespace = "grafana"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {
      http {
        path {
          path     = "/"
          path_type = "Prefix"
          backend {
            service {
              name = helm_release.grafana.name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [helm_release.grafana]
}

