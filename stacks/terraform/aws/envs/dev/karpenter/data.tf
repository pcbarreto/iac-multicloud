data "aws_ecrpublic_authorization_token" "token" {}
data "aws_eks_cluster_auth" "auth" {
    name = var.cluster_name
}
data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}
