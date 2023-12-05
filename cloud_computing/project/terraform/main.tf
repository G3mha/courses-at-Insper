terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  required_version = ">= 1.2.0"
  
  backend "s3" {
    bucket         = "enricco-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "enricco-terraform-state-lock"
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "enricco-vpc"
  cidr = "172.31.0.0/16"
  azs = var.azs

  # Define CIDR blocks for your private subnets
  private_subnets = ["172.31.0.0/26", "172.31.0.64/26"]

  # Define CIDR blocks for your public subnets
  public_subnets = ["172.31.0.128/26", "172.31.0.192/26"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "Development"
    Project = "Enricco"
  }
}

output "alb_dns_name" {
    value = "${aws_alb.alb.dns_name}/docs"
}

output "locust_dns_name" {
    value = "${aws_instance.locust.public_ip}:8089"
}