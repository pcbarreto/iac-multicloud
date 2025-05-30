data "aws_partition" "current" {}

data "aws_eks_cluster_auth" "auth" {
  name = var.cluster_name
}
data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.us_east_1
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks.cluster_name
  ]
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "poc-multi-cloud-tfstate"
    key    = "env:/dev/vpc/stacks-terraform.tfstate"
    region = "us-east-1"
  }
  depends_on = [
    module.vpc
  ]
}