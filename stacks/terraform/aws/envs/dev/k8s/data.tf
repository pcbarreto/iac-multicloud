data "aws_eks_cluster_auth" "auth" {
  name = var.cluster_name
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  key    = "vpc/stacks-terraform.tfstate"
  region = "us-east-1"
  config = {
    workspaces = {
      name = "dev"
    }
  }
}