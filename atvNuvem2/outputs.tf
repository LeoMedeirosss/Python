<<<<<<< HEAD
output "service_info" {
  value = {
    service_name = kubernetes_service_v1.todo_app_svc.metadata[0].name
    service_type = kubernetes_service_v1.todo_app_svc.spec[0].type
  }
}
=======
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
>>>>>>> b7a091b10d0a47374f3ecad31c3af79d7f3a1159
