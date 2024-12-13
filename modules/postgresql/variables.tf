variable "namespace" {
  description = "The namespace where PostgreSQL will be deployed"
  default     = "postgresql"
}

variable "postgres_user" {
  description = "The username for PostgreSQL"
  default     = "authentik"
}

variable "postgres_password" {
  description = "The password for PostgreSQL"
  default     = "authentik_password"
}

variable "postgres_database" {
  description = "The name of the database"
  default     = "authentik"
}

variable "persistence_enabled" {
  description = "Enable persistence for PostgreSQL"
  default     = true
}

variable "storage_class" {
  description = "Storage class for PostgreSQL persistent volume"
  default     = "gp2"
}

variable "storage_size" {
  description = "Storage size for PostgreSQL persistent volume"
  default     = "10Gi"
}

