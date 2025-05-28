stack {
  name        = "AWS Karpenter Dev"
  description = "Stack to manage the main Karpenter"
  id          = "eaaf0b87-f975-4a99-a370-e3131bbcc33a"
  tags        = [
    "core",
    "karpenter",
    "dev"
  ]

  after = [
    "tag:eks"
  ]
}

input "cluster_name" {
  backend       = "default"
  from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
  value         = outputs.cluster_name.value
  mock          = "cluster-dev"
}

input "cluster_endpoint" {
  backend       = "default"
  from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
  value         = outputs.cluster_endpoint.value
  mock          = "https://cluster_endpoint:8080"
}

input "cluster_certificate_authority_data" {
  backend       = "default"
  from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
  value         = outputs.cluster_certificate_authority_data.value
  mock          = "ZXhhbXBsZS1jZXJ0aWZpY2F0ZS1hdXRob3JpdHktZGF0YQo="
}

# input "ami_type" {
#   backend       = "default"
#   from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
#   value         = "AL2023_x86_64_STANDARD"
#   mock          = "AL2023_x86_64_STANDARD"
# }
#
# input "karpenter_service_account" {
#     backend       = "default"
#     from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
#     value         = outputs.karpenter_service_account.value
#     mock          = "karpenter-service-account"
# }
#
# input "karpenter_queue_name" {
#     backend       = "default"
#     from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
#     value         = outputs.karpenter_queue_name.value
#     mock          = "karpenter-queue"
# }
#
# input "karpenter_node_iam_role_name" {
#     backend       = "default"
#     from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
#     value         = outputs.karpenter_node_iam_role_name.value
#     mock          = "karpenter-node-role"
# }