output "service_info" {
  value = {
    service_name = kubernetes_service_v1.todo_app_svc.metadata[0].name
    service_type = kubernetes_service_v1.todo_app_svc.spec[0].type
  }
}
