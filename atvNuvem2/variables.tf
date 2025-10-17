variable "region" {
  description = "Região da AWS onde o cluster está localizado"
  type        = string
  default     = "eu-central-1"
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.region))
    error_message = "A região deve ser um identificador válido da AWS."
  }
}

variable "cluster_name" {
  description = "Nome do cluster EKS existente"
  default     = "eksDeepDiveFrankfurt"
}

variable "vpc_id" {
  description = "ID da VPC existente"
  default     = "vpc-6412160f"
}

variable "subnets" {
  description = "Subnets existentes associadas ao cluster"
  type        = list(string)
  default     = ["subnet-75144e08", "subnet-556d813f"]
}

variable "security_group_id" {
  description = "Security Group existente"
  default     = "sg-0698f55cc72173814"
}

variable "node_role_arn" {
  description = "ARN da função IAM dos nodes"
  default     = "arn:aws:iam::325583868777:role/for-nodegroup-eksDeepDiveFrankfurt"
}

variable "app_image" {
  description = "Imagem Docker da aplicação To-do List"
  default     = "SEU_USUARIO_DOCKER/todo-list:latest" # <-- altere aqui
}

# Variáveis adicionais do terraform.tfvars
variable "aws_region" {
  description = "Região da AWS (alias para region)"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
  default     = "eksDeepDiveFrankfurt-vpc"
}

variable "security_group_name" {
  description = "Nome do Security Group"
  type        = string
  default     = "eksDeepDiveFrankfurt-sg"
}

variable "node_group_name" {
  description = "Nome do Node Group"
  type        = string
  default     = "lmf-hcmr-node-group"
}

variable "todo_image" {
  description = "Imagem Docker da aplicação To-do List (alias para app_image)"
  type        = string
  default     = "docker.io/seuusuario/todo-list:latest"
}

variable "scaling_min" {
  description = "Número mínimo de réplicas"
  type        = number
  default     = 1
}

variable "scaling_desired" {
  description = "Número desejado de réplicas"
  type        = number
  default     = 1
}

variable "scaling_max" {
  description = "Número máximo de réplicas"
  type        = number
  default     = 2
}
