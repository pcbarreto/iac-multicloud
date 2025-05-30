stack {
  name        = "AWS EKS Dev"
  description = "Stack to manage the main EKS"
  id          = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
  tags = [
    "eks",
    "dev"
  ]

  after = [
    "tag:vpc"
  ]
}

input "vpc_id" {
  backend       = "default"
  from_stack_id = "b3d2a2f3-be45-4950-bd10-66da2d727414"
  value         = outputs.vpc_id.value
  mock          = "vpc-12342255678"
}

input "intra_subnets" {
  backend       = "default"
  from_stack_id = "b3d2a2f3-be45-4950-bd10-66da2d727414"
  value         = outputs.intra_subnets.value
  mock          = ["subnet-12345678", "subnet-87654321", "subnet-11223344"]
}

input "private_subnets" {
  backend       = "default"
  from_stack_id = "b3d2a2f3-be45-4950-bd10-66da2d727414"
  value         = outputs.private_subnets.value
  mock          = ["subnet-12345678", "subnet-87654321", "subnet-11223344"]
}

output "cluster_name" {
  backend   = "default"
  value     = module.eks.cluster_name
  sensitive = false
}

output "cluster_endpoint" {
  backend   = "default"
  value     = module.eks.cluster_endpoint
  sensitive = false
}

output "cluster_certificate_authority_data" {
  backend   = "default"
  value     = module.eks.cluster_certificate_authority_data
  sensitive = true
}
