# output "authentik_url" {
#   value = "http://${module.eks_cluster.cluster_endpoint}:${kubernetes_service.authentik_service.spec[0].port[0].node_port}"
# }
# Outputs from the Authentik Module
output "namespace" {
  description = "The namespace where Authentik is deployed"
  value       = kubernetes_namespace.authentik.metadata[0].name
}

output "helm_release_name" {
  description = "The name of the Helm release for Authentik"
  value       = helm_release.authentik.name
}
