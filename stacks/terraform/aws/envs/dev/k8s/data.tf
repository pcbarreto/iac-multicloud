data "aws_eks_cluster_auth" "auth" {
  name = var.cluster_name
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "poc-multi-cloud-tfstate"
    key    = "env:/dev/vpc/stacks-terraform.tfstate"
    region = "us-east-1"
  }
}