terraform {
  backend "s3" {
    bucket       = "poc-multicloud-tfstate"
    encrypt      = true
    key          = "resources/stacks-terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}