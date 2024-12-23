output "vpc_id" {
  value = module.networking.vpc_id
}

output "eks_cluster_name" {
  value = module.eks_cluster.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}

output "eks_node_group_name" {
  value = module.eks_node_group.node_group_name
}

output "authentik_namespace" {
  value = module.authentik.namespace
}

output "authentik_helm_release_name" {
  value = module.authentik.helm_release_name
}