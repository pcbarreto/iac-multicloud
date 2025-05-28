# stack {
#   name        = "AWS Resources Dev"
#   description = "Stack to manage the main Resources"
#   id          = "b6a03fda-6f82-4726-8ad8-b5956f5a511f"
#
#   tags        = ["resources", "dev"]
#   after = [
#     "tag:eks"
#   ]
# }
#
# input "cluster_name" {
#   backend       = "default"
#   from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
#   value         = outputs.cluster_name.value
#   mock          = "cluster-dev"
# }
#
# input "cluster_endpoint" {
#   backend       = "default"
#   from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
#   value         = outputs.cluster_endpoint.value
#   mock          = "https://cluster_endpoint:8080"
# }
#
# input "cluster_certificate_authority_data" {
#   backend       = "default"
#   from_stack_id = "fb96b268-d6d7-4e4a-953c-9dc711342beb"
#   value         = outputs.cluster_certificate_authority_data.value
#   mock          = "ZXhhbXBsZS1jZXJ0aWZpY2F0ZS1hdXRob3JpdHktZGF0YQo="
# }