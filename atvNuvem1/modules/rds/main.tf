variable "aws_region" { type = string }
variable "db_subnet_group" { type = string }
variable "vpc_security_group_id" { type = string }
variable "tags" { type = map(string) }

provider "aws" { region = var.aws_region }

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "lmfdb"
  username             = "lmfadmin"
  password             = "ChangeMe123!" # CHANGE in production
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [var.vpc_security_group_id]
  db_subnet_group_name = var.db_subnet_group
  tags = merge(var.tags, { Name = "lmf-mysql" })
  port = 3306
}
output "db_endpoint" {
  value = aws_db_instance.mysql.endpoint
}
