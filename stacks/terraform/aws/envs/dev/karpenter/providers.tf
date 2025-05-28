terraform {
  required_version = "1.12.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.19.0"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.auth.token

    # exec {
    #   api_version = "client.authentication.k8s.io/v1"
    #   command     = "aws"
    #   args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    # }
  }
}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = var.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.auth.token
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  load_config_file       = false

  # exec {
  #   api_version = "client.authentication.k8s.io/v1"
  #   command     = "aws"
  #   args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
  # }
}
provider "aws" {
  region = "us-east-1"
}