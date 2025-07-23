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