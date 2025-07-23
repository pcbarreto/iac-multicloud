data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "pocmulticloud-tfstate"
    key    = "env:/dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}