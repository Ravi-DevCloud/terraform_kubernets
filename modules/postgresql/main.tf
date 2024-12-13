resource "kubernetes_namespace" "postgresql" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "postgresql-main" {
  name       = "authentik-db"
  namespace  = kubernetes_namespace.postgresql.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  timeout = 1200

  set {
    name  = "auth.postgresUser"
    value = var.postgres_user
  }

  set {
    name  = "auth.postgresPassword"
    value = var.postgres_password
  }

  set {
    name  = "auth.postgresDatabase"
    value = var.postgres_database
  }

  set {
    name  = "primary.persistence.enabled"
    value = var.persistence_enabled
  }

  set {
    name  = "primary.persistence.storageClass"
    value = var.storage_class
  }

  set {
    name  = "primary.persistence.size"
    value = var.storage_size
  }
}

