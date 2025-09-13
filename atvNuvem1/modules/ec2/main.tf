resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "this" {
  ami           = "ami-08c40ec9ead489470" # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Bem-vindo! - lmf & hcmr</h1>" > /var/www/html/index.html
              EOF

  tags = merge(var.tags, {
    Name = "lmf-hcmr-ec2"
  })
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "db_security_group_id" {
  value = aws_security_group.ec2_sg.id
}
