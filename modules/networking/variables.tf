variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "internet_gateway_name" {
  description = "Name for the Internet Gateway"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "availability_zone_1" {
  description = "Availability Zone for the first subnet"
  type        = string
}
variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}
variable "availability_zone_2" {
  description = "Availability Zone for the second subnet"
  type        = string
}



# variable "public_subnet_2_cidr" {
#   description = "CIDR block for the second public subnet"
#   type        = string
# }


# variable "private_subnet_2_cidr" {
#   description = "CIDR block for the second private subnet"
#   type        = string
# }



