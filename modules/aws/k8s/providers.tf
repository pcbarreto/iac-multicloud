terraform {
  required_version = "1.12.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.100.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
    # kubectl = {
    #   source  = "gavinbunney/kubectl"
    #   version = "1.19.0"
    # }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = module.eks.cluster_auth_token

  # exec {
  #   api_version = "client.authentication.k8s.io/v1"
  #   args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  #   command     = "aws"
  # }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = module.eks.cluster_auth_token

    #   exec {
    #     api_version = "client.authentication.k8s.io/v1"
    #     command     = "aws"
    #     args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    #   }
  }
}

# provider "kubectl" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   token                  = module.eks.cluster_auth_token
#   load_config_file       = false
#
#   exec {
#     api_version = "client.authentication.k8s.io/v1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }
# }
