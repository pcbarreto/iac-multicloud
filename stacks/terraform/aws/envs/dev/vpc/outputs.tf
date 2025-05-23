output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = ""
  value       = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  description = ""
  value       = module.vpc.public_subnets
}

