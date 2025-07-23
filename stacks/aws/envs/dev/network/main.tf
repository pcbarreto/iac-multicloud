module "network" {
  source = "../../../../../modules/aws/network"

  vpc_name               = var.vpc_name
  vpc_cidr               = var.vpc_cidr
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

}