variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}


variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "enable_nat_gateway" {
  description = "Enable or disable NAT Gateway"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Enable or disable NAT Gateway"
  type        = bool
}

variable "one_nat_gateway_per_az" {
  description = "Enable or disable NAT Gateway"
  type        = bool
}


# locals {
#   azs = slice(data.aws_availability_zones.available.names, 0, 3)
# }
