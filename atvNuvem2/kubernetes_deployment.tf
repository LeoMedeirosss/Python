# Deployment da aplicação To-do List
resource "kubernetes_deployment_v1" "todo_app" {
  metadata {
    name = "todo-list-app"
    labels = {
      app = "todo-list"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "todo-list"
      }
    }

    template {
      metadata {
        labels = {
          app = "todo-list"
        }
      }

      spec {
        container {
          name  = "todo-list"
          image = "nginx:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }

  # Aguardar o Node Group estar pronto
  depends_on = [aws_eks_node_group.todo_app_node_group]
}

# Service para expor a aplicação
resource "kubernetes_service_v1" "todo_app_svc" {
  metadata {
    name = "todo-list-service"
  }

  spec {
    selector = {
      app = "todo-list"
    }

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }

  # Aguardar o Node Group estar pronto
  depends_on = [aws_eks_node_group.todo_app_node_group]
}
