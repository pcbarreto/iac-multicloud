stack {
  name        = "AWS Karpenter Dev"
  description = "Stack to manage the main Karpenter"
  id          = "eaaf0b87-f975-4a99-a370-e3131bbcc33a"
  tags = [
    "asg",
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

input "cluster_oidc_issuer_url" {
  backend       = "default"
  from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
  value         = outputs.cluster_oidc_issuer_url.value
  mock          = "https://oidc.eks.us-east-1.amazonaws.com/id/45646456"
}
