resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = merge(var.tags, {
    Name = "lmf-hcmr-vpc"
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "lmf-hcmr-public-subnet"
  })
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.2.0/24"

  tags = merge(var.tags, {
    Name = "lmf-hcmr-private-subnet"
  })
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "db_subnet_group" {
  value = aws_subnet.private.id
}
