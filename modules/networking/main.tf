resource "aws_vpc" "kub-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.kub-vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

# Public Subnet in AZ1
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.kub-vpc.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

# Private Subnet in AZ2
resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.kub-vpc.id
  cidr_block              = var.private_subnet_1_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kub-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_association_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.kub-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_association_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}


resource "aws_security_group" "eks_cluster" {
  vpc_id = aws_vpc.kub-vpc.id

  # Allow communication between nodes and the EKS control plane
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = [aws_vpc.kub-vpc.cidr_block]
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    description = "Allow traffic between nodes"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "Allow HTTPS traffic"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow HTTP traffic"
  }
   ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow SSH access"
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}

# Security Group for EKS Node Group (for the EC2 instances)
resource "aws_security_group" "eks_node_group" {
  vpc_id = aws_vpc.kub-vpc.id

  # Allow inbound SSH traffic to the nodes for debugging purposes (can be limited to specific IP ranges)
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow SSH access to EKS nodes"
  }
   ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow HTTP traffic"
  }

  # Allow communication from nodes to control plane
  ingress {
    cidr_blocks = [aws_vpc.kub-vpc.cidr_block]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "Allow HTTPS communication between nodes and control plane"
  }

  # Allow outbound traffic
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
  }

  tags = {
    Name = "eks-node-group-sg"
  }
}
