<<<<<<< HEAD
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
=======
variable "aws_region" {
default = "eksDeepDiveFrankfurt"
}


variable "vpc_name" {
description = "Tag Name da VPC utilizada pelo cluster"
type = string
default = "eksDeepDiveFrankfurt-vpc"
}


variable "security_group_name" {
description = "Tag Name do Security Group do cluster"
type = string
default = "eksDeepDiveFrankfurt-sg"
}


variable "node_group_name" {
description = "Nome do Node Group que será criado"
type = string
default = "nodeGroup01"
}


variable "instance_type" {
description = "Tipo da instância EC2 para os nós"
type = string
default = "t3.small"
}


variable "node_role_arn" {
description = "ARN da IAM Role usada pelos nós do cluster (precisa existir)"
type = string
}


variable "todo_image" {
description = "Imagem Docker da aplicação To-do List"
type = string
default = "docker.io/seuusuario/todo-list:latest"
}


variable "todo_container_port" {
description = "Porta exposta pelo container da app"
type = number
default = 3000
}


variable "todo_service_port" {
description = "Porta do service exposta externamente"
type = number
default = 80
}


variable "todo_replicas" {
description = "Número de réplicas do Deployment"
type = number
default = 1
}


variable "scaling_min" {
description = "Mínimo de instâncias no node group"
type = number
default = 1
}


variable "scaling_desired" {
description = "Tamanho desejado inicial do node group"
type = number
default = 1
}


variable "scaling_max" {
description = "Máximo de instâncias no node group"
type = number
default = 2
}
>>>>>>> b7a091b10d0a47374f3ecad31c3af79d7f3a1159
