data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_ecrpublic_authorization_token" "token" {}
data "aws_eks_cluster_auth" "auth" {
  name = var.cluster_name
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  depends_on = [
    module.eks.cluster_name
  ]
}

# data "terraform_remote_state" "vpc" {
#   backend = "s3"
#   config = {
#     bucket = "poc-multi-cloud-tfstate"
#     key    = "env:/dev/vpc/stacks-terraform.tfstate"
#     region = "us-east-1"
#   }
# }
