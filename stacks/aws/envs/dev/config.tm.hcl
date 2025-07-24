globals "environment" {
  env = "dev"
}

globals "terraform" "backend" {
  bucket      = "pocmulticloud-tfstate"
  region      = "us-east-1"
  Environment = global.environment.env
}


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


