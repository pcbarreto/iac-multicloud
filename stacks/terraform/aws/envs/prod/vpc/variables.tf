variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}

variable "region" {
  description = "Name of region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "enable_nat_gateway" {
  description = "Enable or disable NAT Gateway"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Enable or disable NAT Gateway"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Enable or disable NAT Gateway"
  type        = bool
  default     = false
}


variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
  tags = {
    ManagedBy = "Terraform"
    Owner     = "Pcbarreto"
  }
}
