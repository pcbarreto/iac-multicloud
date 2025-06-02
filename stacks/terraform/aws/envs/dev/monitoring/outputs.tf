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
