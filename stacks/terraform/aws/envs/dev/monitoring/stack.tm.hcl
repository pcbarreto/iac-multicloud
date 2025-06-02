stack {
  name        = "AWS LGTM Monitoring Dev"
  description = "Observality stack for AWS"
  id          = "05dce857-e9a1-4f3b-9438-58ed00066713"
  tags        = ["lgtm", "dev"]

  after = [
    "tag:resources"
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

input "cluster_certificate_authority_data" {
  backend       = "default"
  from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
  value         = outputs.cluster_certificate_authority_data.value
  mock          = "2048c7ae88996e57d4993bb44571a77e5c15bde632f08b53302c114c7341fa88"
}

