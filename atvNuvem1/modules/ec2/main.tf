variable "aws_region" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_id" { type = string }
variable "tags" { type = map(string) }

provider "aws" { region = var.aws_region }

resource "aws_security_group" "web_sg" {
  name = "lmf-web-sg"
  vpc_id = var.vpc_id
  description = "Allow HTTP from anywhere and allow MySQL from self to RDS SG"
  tags = merge(var.tags, { Name = "lmf-web-sg" })

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl enable apache2
              systemctl start apache2
              echo "<h1>Servidor Apache provisionado via Terraform - LMF</h1>" > /var/www/html/index.html
              EOF

  tags = merge(var.tags, { Name = "lmf-web-instance" })
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] # Canonical
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
# Security group id output intended to be used by RDS module
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "db_security_group_id" {
  value = aws_security_group.web_sg.id
}
