variable "cidr_block_main" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name_main" {
  description = "Name of the VPC"
  type        = string
}

variable "internet_gateway_name_main" {
  description = "Name for the Internet Gateway"
  type        = string
}

variable "public_subnet_1_cidr_main" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "availability_zone_1_main" {
  description = "Availability Zone for the first subnet"
  type        = string
}
variable "private_subnet_1_cidr_main" {
  description = "CIDR block for the first private subnet"
  type        = string
}
variable "availability_zone_2_main" {
  description = "Availability Zone for the second subnet"
  type        = string
}

variable "eks_cluster_name_main" {
  description = "The name of the EKS cluster"
  type        = string
  
}