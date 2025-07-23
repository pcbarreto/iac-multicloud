globals "terraform" "backend" {
  bucket = "pocmulticloud-tfstate"
  region = "us-east-1"
}

# globals "terraform" "tags" {
#   Environment = "dev"
#   Owner       = "Platform Engineering"
#   ManagedBy   = "Terraform"
#   GithubRepo  = "iac-multicloud"
#   GithubOrg   = "PcBarreto"
# }

# generate_hcl "locals.tf" {
#   content {
#     locals {
#       tags = {
#         Environment = "dev"
#         Owner       = "Platform Engineering"
#         ManagedBy   = "Terraform"
#         GithubRepo  = "iac-multicloud"
#         GithubOrg   = "PcBarreto"
#       }
#     }
#   }
# }


generate_hcl "backend.tf" {
  content {
    terraform {
      backend "s3" {
        region       = global.terraform.backend.region
        bucket       = global.terraform.backend.bucket
        key          = "${terramate.stack.path.basename}/terraform.tfstate"
        use_lockfile = true
      }
    }
  }
}
