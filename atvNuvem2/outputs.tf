output "cluster_name" {
value = data.aws_eks_cluster.eks.name
}


output "node_group_name" {
value = aws_eks_node_group.node_group_dupla.node_group_name
}


output "todo_service_external" {
description = "Endpoint externo gerado pelo Load Balancer (pode demorar)"
value = kubernetes_service.todo_service.status[0].load_balancer[0].ingress[0].hostname
# Atenção: esse output só terá valor após o LoadBalancer ser provisionado.
}