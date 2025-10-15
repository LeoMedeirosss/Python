<<<<<<< HEAD
# Datasource do Node Group existente
data "aws_eks_node_group" "existing_nodegroup" {
  cluster_name = var.cluster_name
  node_group_name = "nodegroup-eksDeepDiveFrankfurt"
}

output "nodegroup_info" {
  value = {
    nodegroup_name = data.aws_eks_node_group.existing_nodegroup.node_group_name
    arn            = data.aws_eks_node_group.existing_nodegroup.arn
    status         = data.aws_eks_node_group.existing_nodegroup.status
  }
}
=======
# Data sources: VPC, Subnets, Security Group, Cluster
data "aws_vpc" "eks_vpc" {
filter {
name = "tag:Name"
values = [var.vpc_name]
}
}


data "aws_subnets" "eks_subnets" {
filter {
name = "vpc-id"
values = [data.aws_vpc.eks_vpc.id]
}
}


data "aws_security_group" "eks_sg" {
filter {
name = "tag:Name"
values = [var.security_group_name]
}
}


# opcional: referenciar role se quiser buscar via name (alternativa ao usar arn diretamente)
# data "aws_iam_role" "node_role" {
# name = var.node_role_name
# }


# Node Group
resource "aws_eks_node_group" "node_group_dupla" {
cluster_name = data.aws_eks_cluster.eks.name
node_group_name = var.node_group_name
node_role_arn = var.node_role_arn
subnet_ids = data.aws_subnets.eks_subnets.ids


scaling_config {
desired_size = var.scaling_desired
min_size = var.scaling_min
max_size = var.scaling_max
}


instance_types = [var.instance_type]


# Tags e labels opcionais
tags = {
Name = var.node_group_name
}


depends_on = [data.aws_eks_cluster.eks]
}
>>>>>>> b7a091b10d0a47374f3ecad31c3af79d7f3a1159
