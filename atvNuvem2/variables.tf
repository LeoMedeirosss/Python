variable "region" {
  description = "Região da AWS onde o cluster está localizado"
  default     = "eu-central-1"
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
