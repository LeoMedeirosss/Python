# Deployment e Service para a aplicação To-Do List
metadata {
name = "todo-app"
labels = {
app = "todo"
}
}


spec {
replicas = var.todo_replicas


selector {
match_labels = {
app = "todo"
}
}


template {
metadata {
labels = {
app = "todo"
}
}


spec {
container {
name = "todo"
image = var.todo_image
port {
container_port = var.todo_container_port
}


# readiness/liveness probes podem ser adicionadas se quiser
}
}
}
}


resource "kubernetes_service" "todo_service" {
metadata {
name = "todo-service"
labels = {
app = "todo"
}
}


spec {
selector = {
app = kubernetes_deployment.todo_app.metadata[0].labels.app
}


port {
port = var.todo_service_port
target_port = var.todo_container_port
}


type = "LoadBalancer"
}
}