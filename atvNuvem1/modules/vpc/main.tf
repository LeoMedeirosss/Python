variable "aws_region" { type = string }
variable "tags" { type = map(string) }

provider "aws" { region = var.aws_region }

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(var.tags, { Name = "lmf-vpc" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, { Name = "lmf-igw" })
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = merge(var.tags, { Name = "lmf-public-subnet" })
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = merge(var.tags, { Name = "lmf-private-subnet" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, { Name = "lmf-public-rt" })
}

resource "aws_route" "internet_access" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_db_subnet_group" "rds_subnets" {
  name = "lmf-rds-subnet-group"
  subnet_ids = [aws_subnet.private.id]
  tags = merge(var.tags, { Name = "lmf-rds-subnet-group" })
}

data "aws_availability_zones" "available" {}
