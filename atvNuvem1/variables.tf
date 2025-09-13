variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "backend_bucket" {
  description = "Nome do bucket S3 para armazenar o estado remoto"
  type        = string
  default     = "lmf-hcmr-tfstate"
}

variable "tag_aluno" {
  description = "Tag de identificação do aluno"
  type        = string
  default     = "lmf-hcmr"
}

variable "tag_periodo" {
  description = "Tag do período"
  type        = string
  default     = "8"
}
