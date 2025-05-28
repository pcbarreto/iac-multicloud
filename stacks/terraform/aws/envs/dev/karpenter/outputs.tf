output "karpenter_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.karpenter.queue_arn
}

output "karpenter_queue_name" {
  description = "The name of the created Amazon SQS queue"
  value       = module.karpenter.queue_name
}

output "karpenter_queue_url" {
  description = "The URL for the created Amazon SQS queue"
  value       = module.karpenter.queue_url
}

output "karpenter_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.karpenter.instance_profile_arn
}

output "karpenter_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.karpenter.instance_profile_id
}

output "karpenter_instance_profile_name" {
  description = "Name of the instance profile"
  value       = module.karpenter.instance_profile_name
}

output "karpenter_iam_role_name" {
  description = "The name of the controller IAM role"
  value       = module.karpenter.iam_role_name
}

output "karpenter_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the controller IAM role"
  value       = module.karpenter.iam_role_arn
}