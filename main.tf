provider "aws" {
  region                   = "ap-southeast-1"
  shared_config_files      = ["C:/Users/QA-010518-004/.aws/config"]
  shared_credentials_files = ["C:/Users/QA-010518-004/.aws/credentials"]
  profile                  = "default"
}

terraform {
  required_version = "~> 1.2.0"
  required_providers {
    aws = {
      version = "~> 4.21.0"
      source  = "hashicorp/aws"
    }
  }
}

module "vpc" {
  source      = "./modules/vpc"
  name        = var.name
  environment = var.environment
  cidr        = var.cidr
  az_count    = var.az_count
}

module "s3" {
  source      = "./modules/s3"
  name        = var.name
  environment = var.environment
}

module "ec2" {
  source        = "./modules/ec2"
  name          = var.name
  environment   = var.environment
  instanceType  = "t3.nano"
  privateSubnet = module.vpc.private_subnets[0].id
}

module "route53" {
  source               = "./modules/route53"
  name                 = var.name
  environment          = var.environment
  vpcId                = module.vpc.id
  ec2InstancePrivateIp = module.ec2.ec2InstancePrivateIp
  depends_on = [
    module.vpc
  ]

}
