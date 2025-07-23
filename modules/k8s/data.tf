data "aws_eks_cluster_auth" "auth" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "pocmulticloud-tfstate"
    key    = "env:/dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}