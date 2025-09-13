variable "aws_region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}

variable "backend_bucket" {
  description = "S3 bucket name for Terraform state backend (must exist)"
  type = string
  default = "lmf-dupla-tfstate-0001"
}

variable "tag_aluno" {
  type = string
  default = "LMF"
}

variable "tag_periodo" {
  type = string
  default = "8"
}
