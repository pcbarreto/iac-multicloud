data "aws_eks_cluster_auth" "auth" {
  name = var.cluster_name
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "poc-multi-cloud-tfstate"
    key    = "env:/dev/k8s/stacks-terraform.tfstate"
    region = "us-east-1"
  }
}