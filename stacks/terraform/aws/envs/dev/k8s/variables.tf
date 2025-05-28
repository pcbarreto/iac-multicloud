variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = "cluster-dev"
}

variable "cluster_version" {
  description = "Version of Kubernetes to install the cluster"
  type        = string
  default     = "1.32"
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
  default     = "AL2023_x86_64_STANDARD"
}

variable "instance_types" {
  description = "Worker instance types for worker nodes"
  type        = list(string)
  default     = ["t3.medium", "t3a.medium"]
}

variable "min_size" {
  description = "Minimum number of nodes for the cluster."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes for the cluster."
  type        = number
  default     = 5
}

variable "desired_size" {
  description = "Desired number of nodes for the cluster."
  type        = number
  default     = 3
}

