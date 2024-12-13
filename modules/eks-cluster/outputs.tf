# Output the EKS cluster endpoint
output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

# Output the EKS cluster certificate authority data
output "cluster_certificate_authority_data" {
   value = aws_eks_cluster.this.certificate_authority[0].data
}

# Output the EKS cluster name
output "cluster_name" {
  value = aws_eks_cluster.this.name
}