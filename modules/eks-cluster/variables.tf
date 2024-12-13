variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "eks_role_arn" {
  description = "The IAM role ARN to associate with the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to use for the EKS cluster"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EKS cluster"
  type        = list(string)
}
