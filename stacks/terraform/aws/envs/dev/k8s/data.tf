data "aws_eks_cluster_auth" "auth" {
  name = var.cluster_name
}
data "aws_availability_zones" "available" {}

data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    bucket = "poc-multi-cloud-tfstate"
    key    = "vpc/stacks-terraform.tfstate"
    region = "us-east-1"
    workspaces = {
      name = "dev"
    }
  }
}