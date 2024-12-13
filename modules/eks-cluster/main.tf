resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn  # IAM Role for the EKS Cluster

  vpc_config {
    subnet_ids = var.subnet_ids  # Subnets where the cluster control plane will be deployed
    security_group_ids = var.security_group_ids  # Security groups for the cluster
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]

}


