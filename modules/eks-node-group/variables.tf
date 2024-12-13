variable "cluster_name" {
  description = "The name of the EKS cluster to attach this node group to."
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group."
  type        = string
}

variable "node_role_arn" {
  description = "The ARN of the IAM role to associate with the EKS node group."
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnets to deploy the node group into."
  type        = list(string)
}

# variable "security_group_ids" {
#   description = "The list of subnets to deploy the node group into."
#   type        = list(string)
# }

variable "desired_size" {
  description = "The desired number of nodes in the node group."
  type        = number
  default     = 2
}

variable "min_size" {
  description = "The minimum number of nodes in the node group."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of nodes in the node group."
  type        = number
  default     = 4
}

variable "instance_types" {
  description = "The instance types to use for the node group."
  type        = list(string)
}


# variable "default_tags" {
#   description = "A map of default tags to assign to the node group resources."
#   type        = map
#   default     = {}
# }
