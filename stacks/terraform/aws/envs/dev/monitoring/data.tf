data "aws_eks_cluster_auth" "auth" {
  name = var.cluster_name
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

# Opcional: pegar o endpoint externo (LoadBalancer) do Grafana
data "kubernetes_service" "grafana" {
  metadata {
    name      = helm_release.grafana.name
    namespace = helm_release.grafana.namespace
  }
  depends_on = [helm_release.grafana]
}

# data "terraform_remote_state" "eks" {
#   backend = "s3"
#   config = {
#     bucket = "poc-multicloud-tfstate"
#     key    = "env:/dev/k8s/stacks-terraform.tfstate"
#     region = "us-east-1"
#   }
# }
