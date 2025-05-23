stack {
  name        = "AWS VPC Network Dev"
  description = "Stack to manage the main VPC Network"
  id          = "b3d2a2f3-be45-4950-bd10-66da2d727414"
  tags        = [
    "core",
    "vpc",
    "dev"
  ]
}

output "vpc_id" {
  backend       = "default"
  value         = module.vpc.vpc_id
  sensitive    = false
}

output "intra_subnets" {
  backend       = "default"
  value         = module.vpc.intra_subnets
  sensitive    = false
}

output "private_subnets" {
  backend       = "default"
  value         = module.vpc.private_subnets
  sensitive    = false
}