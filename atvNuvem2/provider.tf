terraform {
<<<<<<< HEAD
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}

provider "aws" {
  region = var.region
}

# Provedor Kubernetes configurado via credenciais do cluster EKS existente
data "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_auth.token
}
=======
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
>>>>>>> b7a091b10d0a47374f3ecad31c3af79d7f3a1159
