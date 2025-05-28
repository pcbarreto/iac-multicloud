// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket       = "poc-multi-cloud-tfstate"
    key          = "vpc/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
