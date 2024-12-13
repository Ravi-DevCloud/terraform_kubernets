output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.kub-vpc.id
}

output "public_subnet_1_id" {
  description = "The ID of the first public subnet"
  value       = aws_subnet.public_1.id
}

# output "public_subnet_2_id" {
#   description = "The ID of the second public subnet"
#   value       = aws_subnet.public_2.id
# }

output "private_subnet_1_id" {
  description = "The ID of the first private subnet"
  value       = aws_subnet.private_1.id
}

# output "private_subnet_2_id" {
#   description = "The ID of the second private subnet"
#   value       = aws_subnet.private_2.id
# }

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.ig.id
}

output "subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_1.id, aws_subnet.private_1.id]
}

output "security_group_ids" {
  description = "List of security group IDs"
  value       = [aws_security_group.eks_cluster.id, aws_security_group.eks_node_group.id]
  
}