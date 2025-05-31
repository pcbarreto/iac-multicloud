// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

variable "vpc_id" {
  type = any
}
variable "intra_subnets" {
  type = any
}
variable "private_subnets" {
  type = any
}
output "cluster_name" {
  value     = module.eks.cluster_name
  sensitive = false
}
output "cluster_endpoint" {
  value     = module.eks.cluster_endpoint
  sensitive = false
}
output "cluster_certificate_authority_data" {
  value     = module.eks.cluster_certificate_authority_data
  sensitive = true
}
output "cluster_oidc_issuer_url" {
  value     = module.eks.cluster_oidc_issuer_url
  sensitive = false
}
