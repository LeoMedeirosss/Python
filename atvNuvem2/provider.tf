terraform {
required_version = ">= 1.6.0"


required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 5.0"
}
kubernetes = {
source = "hashicorp/kubernetes"
version = "~> 2.25"
}
}
}


provider "aws" {
region = var.aws_region
}


# Referência ao cluster EKS existente
data "aws_eks_cluster" "eks" {
name = var.cluster_name
}


data "aws_eks_cluster_auth" "eks" {
name = data.aws_eks_cluster.eks.name
}


provider "kubernetes" {
host = data.aws_eks_cluster.eks.endpoint
cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
token = data.aws_eks_cluster_auth.eks.token
}