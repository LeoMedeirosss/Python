variable "aws_region" {
  type = string
}

variable "db_subnet_group" {
  type = string
}

variable "vpc_security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
