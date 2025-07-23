module "eks" {
  source = "../../../../../modules/k8s"

  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  creator_admin_permissions      = var.creator_admin_permissions
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  cluster_enabled_log_types      = var.cluster_enabled_log_types
  ami_type                       = var.ami_type
  instance_types                 = var.instance_types
  min_size                       = var.min_size
  max_size                       = var.max_size
  desired_size                   = var.desired_size
  vpc_id                         = data.terraform_remote_state.network.vpc_id
  subnet_ids                     = data.terraform_remote_state.network.private_subnets
  control_plane_subnet_ids       = data.terraform_remote_state.network.intra_subnets

}