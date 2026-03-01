terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.11.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_id
  secret_key = var.aws_access_secret
}

locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "networking" {
  source = "./modules/networking"

  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  subnet_cidr  = var.subnet_cidr
  az           = var.az
  common_tags  = local.common_tags
}

module "security" {
  source = "./modules/security"

  environment   = var.environment
  vpc_id        = module.networking.vpc_id
  vpc_cidr      = var.vpc_cidr
  ssh_key_path  = var.ssh_key_path
  common_tags   = local.common_tags
}

module "compute" {
  source = "./modules/compute"

  environment       = var.environment
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.networking.subnet_id
  key_name          = module.security.key_pair_name
  security_group_id = module.security.security_group_id
  worker_count      = var.worker_count
  common_tags       = local.common_tags
  scripts_path      = "${path.module}/scripts"
}
