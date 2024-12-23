terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.15.0"
    }
  }
  backend "s3" {
    bucket = "terraform-aks-bucket"
    key    = "statefiles/terraform.tfstate"
    region = "us-east-1" 
  }
}



module "networking" {
  source = "./modules/networking"
  
  cidr_block             = var.cidr_block_main
  vpc_name               = var.vpc_name_main
  internet_gateway_name  = var.internet_gateway_name_main
  public_subnet_1_cidr   = var.public_subnet_1_cidr_main
  private_subnet_1_cidr  = var.private_subnet_1_cidr_main
  availability_zone_1    = var.availability_zone_1_main
  availability_zone_2    = var.availability_zone_2_main
}

module "iam" {
  source = "./modules/iam"
}

module "eks_cluster" {
  source         = "./modules/eks-cluster"
  cluster_name   = var.eks_cluster_name_main
  eks_role_arn   = module.iam.eks_cluster_role_arn  # IAM role ARN from the IAM module
  subnet_ids     = module.networking.subnet_ids  # Subnets from your VPC module
  security_group_ids = module.networking.security_group_ids  # Security group from your security module
}

module "eks_node_group" {
  source          = "./modules/eks-node-group"
  cluster_name    = module.eks_cluster.cluster_name
  node_group_name = "authentik-node-group"
  node_role_arn   = module.iam.eks_worker_role_arn
  subnet_ids      = module.networking.subnet_ids
  desired_size    = 2
  min_size        = 1
  max_size        = 4
  instance_types  = ["t2.small"]
  # security_group_ids = module.networking.security_group_ids
}

# module "authentik" {
#   source = "./modules/authentik"
# }
module "authentik" {
  source            = "./modules/authentik"
  namespace_name    = "authentik"
  helm_chart_version = "2024.10.5"  
  replica_count      = 1
  service_type       = "LoadBalancer"
  postgresql_host     = "authentik-db.${module.postgresql.postgresql_namespace}.svc.cluster.local"
  postgresql_user     = module.postgresql.postgresql_credentials["username"]
  postgresql_password = module.postgresql.postgresql_credentials["password"]
  postgresql_database = module.postgresql.postgresql_credentials["database"]

}


module "postgresql" {
  source            = "./modules/postgresql"
  namespace         = "postgresql"
  postgres_user     = "authentik"
  postgres_password = "authentik_password"
  postgres_database = "authentik"
  persistence_enabled = true
  storage_class       = "gp2"
  storage_size        = "10Gi"
}
