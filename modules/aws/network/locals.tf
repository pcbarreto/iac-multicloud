locals {
  tags = {
    Environment = "dev"
    GithubOrg   = "PcBarreto"
    GithubRepo  = "iac-multicloud"
    ManagedBy   = "Terraform"
    Owner       = "Platform Engineering"
  }
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}
