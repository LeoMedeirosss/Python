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
