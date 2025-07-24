locals {
  tags = merge({
    GithubOrg  = "PcBarreto"
    GithubRepo = "iac-multicloud"
    ManagedBy  = "Terraform"
    Owner      = "Platform Engineering"
    }, {
    Environment = var.environment
  })
}
