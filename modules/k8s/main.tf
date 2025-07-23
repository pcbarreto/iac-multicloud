module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  enable_cluster_creator_admin_permissions = var.creator_admin_permissions
  cluster_endpoint_public_access           = var.cluster_endpoint_public_access
  enable_irsa                              = true
  authentication_mode                      = "API_AND_CONFIG_MAP"
  cluster_enabled_log_types                = var.cluster_enabled_log_types

  vpc_id                   = data.terraform_remote_state.network.vpc_id
  subnet_ids               = [data.terraform_remote_state.network.private_subnets]
  control_plane_subnet_ids = data.terraform_remote_state.network.intra_subnets

  cluster_addons = {
    coredns = {
      most_recent_version = true
    }
    eks-pod-identity-agent = {
      most_recent_version = true
    }
    kube-proxy = {
      most_recent_version = true
    }
    vpc-cni = {
      most_recent_version = true
    }
    aws-ebs-csi-driver = {
      most_recent_version = true
    }
    aws-efs-csi-driver = {
      most_recent_version = true
    }
  }
  eks_managed_node_groups = {
    default = {
      ami_type       = var.ami_type
      instance_types = var.instance_types
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_size

    }

  }
  iam_role_additional_policies = {
    AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }

  tags = local.tags
}