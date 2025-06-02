# outputs.tf

output "grafana_admin_user" {
  value = "admin"
}

output "grafana_admin_password" {
  value     = "ChangeMe123"
  sensitive = true
}

output "grafana_external_url" {
  value       = data.kubernetes_service.grafana.status[0].load_balancer[0].ingress[0].hostname
  description = "Acesse o Grafana por este endpoint (pode demorar alguns minutos após apply)"
}

output "load_balancer_hostname" {
  value = kubernetes_ingress_v1.grafana.status.0.load_balancer.0.ingress.0.hostname
}

# Display load balancer IP (typically present in GCP, or using Nginx ingress controller)
output "load_balancer_ip" {
  value = kubernetes_ingress_v1.grafana.status.0.load_balancer.0.ingress.0.ip
}