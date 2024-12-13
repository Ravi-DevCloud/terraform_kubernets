# Variables for Authentik Module
variable "namespace_name" {
  description = "The name of the namespace for Authentik"
  type        = string
  default     = "authentik"
}

variable "helm_chart_version" {
  description = "The version of the Authentik Helm chart"
  type        = string
}

variable "replica_count" {
  description = "Number of replicas for the Authentik deployment"
  type        = number
  default     = 1
}

variable "service_type" {
  description = "Type of Kubernetes service (e.g., LoadBalancer, NodePort)"
  type        = string
}

# variable "node_port" {
#   description = "NodePort for the service if using NodePort type"
# }

variable "postgresql_host" {
  description = "PostgreSQL service hostname"
}

variable "postgresql_user" {
  description = "PostgreSQL username"
}

variable "postgresql_password" {
  description = "PostgreSQL password"
}

variable "postgresql_database" {
  description = "PostgreSQL database name"
}
