output "postgresql_namespace" {
  description = "The namespace where PostgreSQL is deployed"
  value       = kubernetes_namespace.postgresql.metadata[0].name
}

output "postgresql_credentials" {
  description = "The credentials for PostgreSQL"
  value = {
    username =  var.postgres_user
    password = var.postgres_password
    database = var.postgres_database
  }
}
