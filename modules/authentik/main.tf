# resource "kubernetes_namespace" "authentik" {
#   metadata {
#     name = "authentik"
#   }
# }

# resource "kubernetes_deployment" "authentik" {
#   metadata {
#     name      = "authentik"
#     namespace = kubernetes_namespace.authentik.metadata[0].name
#   }

#   spec {
#     replicas = 1  # Number of replicas, adjust as per your needs

#     selector {
#       match_labels = {
#         app = "authentik"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "authentik"
#         }
#       }

#       spec {
#         container {
#           name  = "authentik"
#           image = "ghcr.io/goauthentik/server:latest"  # Use the appropriate Authentik image
#           port {
#             container_port = 9000  # Expose Authentik on port 9000
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "authentik_service" {
#   metadata {
#     name      = "authentik-service"
#     namespace = kubernetes_namespace.authentik.metadata[0].name
#   }

#   spec {
#     selector = {
#       app = "authentik"
#     }
#     port {
#       port        = 80          # Expose on port 80
#       target_port = 9000       # Target port where Authentik runs inside the pod
#       node_port   = 30080
#     }
#     type = "NodePort"  # Use LoadBalancer to expose the service
#   }
# }

# module "eks_cluster" {
#   source = "./modules/eks-cluster"
# }

# Module for Authentik Deployment

resource "kubernetes_namespace" "authentik" {
  metadata {
    name = var.namespace_name
  }
}

resource "helm_release" "authentik" {
  name       = "authentik"
  namespace  = kubernetes_namespace.authentik.metadata[0].name
  repository = "https://charts.goauthentik.io"
  chart      = "authentik"
  version    = var.helm_chart_version
  timeout = 1200

  set {
    name  = "replicaCount"
    value = var.replica_count
  }
  set {
    name  = "server.service.type"
    value = var.service_type
  }

  set {
    name  = "server.service.servicePortHttp"
    value = 80
  }

  set {
    name  = "server.service.servicePortHttps"
    value = 443
  }
  set {
    name  = "postgresql.host"
    value = var.postgresql_host
  }

  set {
    name  = "postgresql.username"
    value = var.postgresql_user
  }

  set {
    name  = "postgresql.password"
    value = var.postgresql_password
  }

  set {
    name  = "postgresql.database"
    value = var.postgresql_database
  }


#   set {
#     name  = "server.service.loadBalancerSourceRanges"
#     value = ["0.0.0.0/0"] # Allow access from all IPs; adjust as needed
#   }

#   set {
#     name  = "service.type"
#     value = var.service_type
#   }

#   set {
#     name  = "service.nodePort"
#     value = var.node_port
#   }
}
