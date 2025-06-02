stack {
  name        = "AWS Resources Dev"
  description = "Stack to manage the main Resources"
  id          = "b6a03fda-6f82-4726-8ad8-b5956f5a511f"

  tags = ["resources", "dev"]

  after = [
    "tag:asg"
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
  mock          = "https://5256B2BBFA0827119.gr7.us-east-1.eks.amazonaws.com"
}
