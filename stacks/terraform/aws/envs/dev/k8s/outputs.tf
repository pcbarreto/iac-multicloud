output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.cluster_arn
}

# output "cluster_oidc_issuer_url" {
#   description = "The URL on the EKS cluster for the OpenID Connect identity provider"
#   value       = module.eks.cluster_oidc_issuer_url
# }
