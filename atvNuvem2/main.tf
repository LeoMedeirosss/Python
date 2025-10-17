# ========================================
# DATASOURCES - Recursos existentes
# ========================================

# Datasource do Cluster EKS existente
data "aws_eks_cluster" "existing_cluster" {
  name = var.cluster_name
}

# Datasource da VPC existente
data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

# Datasource das Subnets existentes
data "aws_subnets" "existing_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Datasource do Security Group existente
data "aws_security_group" "existing_sg" {
  id = var.security_group_id
}

# Datasource da IAM Role existente para Node Group
data "aws_iam_role" "existing_node_role" {
  name = "role-for-nodegroup-eksDeepDiveFrankfurt"
}

# ========================================
# NODE GROUP - Criar novo Node Group
# ========================================

# Node Group usando a role existente
resource "aws_eks_node_group" "todo_app_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = data.aws_iam_role.existing_node_role.arn
  subnet_ids      = var.subnets

  scaling_config {
    desired_size = var.scaling_desired
    max_size     = var.scaling_max
    min_size     = var.scaling_min
  }

  instance_types = ["t3.small"]

  # Configurações de atualização
  update_config {
    max_unavailable_percentage = 25
  }

  # Configurações de launch template
  capacity_type = "ON_DEMAND"

  tags = {
    Name        = var.node_group_name
    Environment = "production"
    Project     = "todo-app"
  }
}

# ========================================
# OUTPUTS
# ========================================

output "cluster_info" {
  value = {
    cluster_name = data.aws_eks_cluster.existing_cluster.name
    endpoint     = data.aws_eks_cluster.existing_cluster.endpoint
    version      = data.aws_eks_cluster.existing_cluster.version
    status       = data.aws_eks_cluster.existing_cluster.status
  }
}

output "vpc_info" {
  value = {
    vpc_id     = data.aws_vpc.existing_vpc.id
    cidr_block = data.aws_vpc.existing_vpc.cidr_block
  }
}

output "nodegroup_info" {
  value = {
    nodegroup_name = aws_eks_node_group.todo_app_node_group.node_group_name
    arn            = aws_eks_node_group.todo_app_node_group.arn
    status         = aws_eks_node_group.todo_app_node_group.status
    capacity_type  = aws_eks_node_group.todo_app_node_group.capacity_type
  }
}
