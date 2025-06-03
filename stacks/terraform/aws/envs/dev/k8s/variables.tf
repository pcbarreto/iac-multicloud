variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = "cluster-dev"
}

variable "region" {
  description = "AWS region where the cluster will be created"
  type        = string
  default     = "us-east-1"
}

variable "cluster_version" {
  description = "Version of Kubernetes to install the cluster"
  type        = string
  default     = "1.33"
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
  default     = "BOTTLEROCKET_x86_64" #"BOTTLEROCKET_x86_64" "AL2023_x86_64_STANDARD"
}


variable "cluster_enabled_log_types" {
  description = "List of enabled log types for the cluster"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "instance_types" {
  description = "Worker instance types for worker nodes"
  type        = list(string)
  default     = "[m5.large"]
}

variable "min_size" {
  description = "Minimum number of nodes for the cluster."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes for the cluster."
  type        = number
  default     = 7
}

variable "desired_size" {
  description = "Desired number of nodes for the cluster."
  type        = number
  default     = 2
}

# variable "capacity_type" {
#   description = "The capacity type for the node group."
#   type        = string
#   default     = "ON_DEMAND" # "SPOT" "ON_DEMAND"
# }

# variable "instance_types_default" {
#   description = "Worker instance types for worker nodes"
#   type        = list(string)
#   default     = ["t3a.medium"]
# }

# variable "disk_size_default" {
#   description = "Disk size for the worker nodes in GB"
#   type        = number
#   default     = 20
# }

# variable "karpenter_namespace" {
#   description = "Namespace for Karpenter"
#   type        = list(string)
#   default     = ["asg:asg"]
# }

# variable "ami_type_default" {
#   description = "The type of the AMI to use for the instances."
#   type        = string
#   default     = "AL2023_x86_64_STANDARD" #"BOTTLEROCKET_x86_64" "AL2023_x86_64_STANDARD"
# }
