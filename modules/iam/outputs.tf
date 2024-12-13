# Output the IAM roles
output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_worker_role_arn" {
  value = aws_iam_role.eks_worker_role.arn
}