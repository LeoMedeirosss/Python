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