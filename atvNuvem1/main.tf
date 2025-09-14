terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 7.0"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"
  aws_region = var.aws_region
  tags = var.tags
}

module "ec2" {
  source           = "./modules/ec2"
  aws_region       = var.aws_region
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  tags             = var.tags
}

module "rds" {
  source                = "./modules/rds"
  aws_region            = var.aws_region
  vpc_id                = module.vpc.vpc_id
  db_subnet_group       = module.vpc.db_subnet_group
  vpc_security_group_id = module.ec2.db_security_group_id
  tags                  = var.tags
}
