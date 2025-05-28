globals "terraform" "backend" {
  bucket = "poc-multi-cloud-tfstate"
  region = "us-east-1"
}


generate_hcl "backend.tf" {

  content {
    terraform {
      backend "s3" {
        region       = global.terraform.backend.region
        bucket       = global.terraform.backend.bucket
        key          =  "${terramate.stack.path.basename}/terraform.tfstate"
        use_lockfile   = true
      }
    }
  }
}