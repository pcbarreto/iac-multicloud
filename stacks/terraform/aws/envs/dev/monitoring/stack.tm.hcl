# stack {
#   name        = "AWS LGTM Monitoring Dev"
#   description = "Observality stack for AWS"
#   id          = "05dce857-e9a1-4f3b-9438-58ed00066713"
#   tags        = ["lgtm", "dev"]
#
#   after = [
#     "tag:vpc",
#     "tag:eks",
#     "tag:karpenter"
#   ]
# }
#
# input "cluster_name" {
#   backend       = "default"
#   from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
#   value         = outputs.cluster_name.value
#   mock          = "cluster-dev"
# }
# input "cluster_endpoint" {
#   backend       = "default"
#   from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
#   value         = outputs.cluster_endpoint.value
#   mock          = "https://cluster_endpoint:8080"
# }
