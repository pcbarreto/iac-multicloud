terraform {
  backend "s3" {
    bucket       = "poc-multicloud-tfstate"
    key          = "resources/stacks-terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
