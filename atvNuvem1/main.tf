module "s3_backend" {
  source      = "./modules/s3_backend"
  aws_region  = var.aws_region
  bucket_name = var.backend_bucket
  tags = {
    Aluno   = var.tag_aluno
    Periodo = var.tag_periodo
  }
}

module "vpc" {
  source     = "./modules/vpc"
  aws_region = var.aws_region
  tags = {
    Aluno   = var.tag_aluno
    Periodo = var.tag_periodo
  }
}

module "ec2" {
  source           = "./modules/ec2"
  aws_region       = var.aws_region
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  tags = {
    Aluno   = var.tag_aluno
    Periodo = var.tag_periodo
  }
}

module "rds" {
  source               = "./modules/rds"
  aws_region           = var.aws_region
  db_subnet_group      = module.vpc.db_subnet_group
  vpc_security_group_id = module.ec2.db_security_group_id
  tags = {
    Aluno   = var.tag_aluno
    Periodo = var.tag_periodo
  }
}
