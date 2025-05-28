module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  enable_cluster_creator_admin_permissions = var.creator_admin_permissions
  cluster_endpoint_public_access           = var.cluster_endpoint_public_access
  authentication_mode                      = "API_AND_CONFIG_MAP"

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
    aws-efs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.intra_subnets

  eks_managed_node_group_defaults = {
    instance_types = var.instance_types
  }

  eks_managed_node_groups = {
    managed_node = {
      ami_type       = var.ami_type
      instance_types = var.instance_types

      min_size     = var.max_size
      max_size     = var.max_size
      desired_size = var.desired_size
    }
  }

  tags = {
    ManagedBy   = "Terraform"
    Owner       = "Platform Engeneering"
    Environment = "dev"
  }
}