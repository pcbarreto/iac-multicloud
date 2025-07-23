output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.network.vpc_arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.network.vpc_cidr_block
}

output "public_subnets" {
  description = "List of public subnets in the VPC"
  value       = module.network.public_subnets
}

output "vpc_id" {
  description = "The ID of the VPC"
  value = module.network.vpc_id
}

output "private_subnets" {
  description = "List of private subnets in the VPC"
  value = module.network.private_subnets
}

output "intra_subnets" {
  description = "List of intra subnets in the VPC"
  value       = module.network.intra_subnets
}