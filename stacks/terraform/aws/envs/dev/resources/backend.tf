// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket       = "poc-multicloud-tfstate"
    key          = "resources/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
