resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL from EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.vpc_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_db_instance" "this" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = "admin1234"
  skip_final_snapshot    = true
  db_subnet_group_name   = var.db_subnet_group
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = merge(var.tags, {
    Name = "lmf-hcmr-rds"
  })
}

output "endpoint" {
  value = aws_db_instance.this.endpoint
}
