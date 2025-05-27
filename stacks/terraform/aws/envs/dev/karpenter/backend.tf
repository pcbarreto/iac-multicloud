terraform {
  backend "s3" {
    bucket       = "poc-multi-cloud-tfstate"
    encrypt      = true
    key          = "karpenter/stacks-terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}