locals {
  tags = merge({
    GithubOrg  = "PcBarreto"
    GithubRepo = "iac-multicloud"
    ManagedBy  = "Terraform"
    Owner      = "Platform Engineering"
    }, {
    Environment = var.environment
  })
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}
