variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "cluster_version" {
  description = "Version of Kubernetes to install the cluster"
  type        = string
}

variable "creator_admin_permissions" {
  description = "Role ARN to use for administrator created on the cluster"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Endpoint public endpoint public access enabled"
  type        = bool
  default     = true
}

variable "ami_type" {
  description = "The type of the AMI to use for the instances."
  type        = string
}

variable "instance_types" {
  description = "Worker instance types for worker nodes"
  type        = list(string)
}

variable "min_size" {
  description = "Minimum number of nodes for the cluster."
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes for the cluster."
  type        = number
}

variable "desired_size" {
  description = "Desired number of nodes for the cluster."
  type        = number
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
  tags = {
    ManagedBy = "Terraform"
    Owner     = "Pcbarreto"
  }
}