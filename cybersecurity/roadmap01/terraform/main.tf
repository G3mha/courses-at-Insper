terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  required_version = ">= 1.2.0"

  # TODO: In case there is a error with the Certificate we will use 
  # backend "s3" {
  #     bucket = "terraform-state-bucket"
  #     key    = "terraform.tfstate"
  #     region = "us-west-2"
  # }
}

provider "aws" {
  region = var.region
}

// === VPC Modules + Resources
// CSP1 = Cybersecurity Project 1

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "csp1-vpc"
  cidr = "172.31.0.0/16"
  azs  = var.azs

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  # reuse_nat_ips      = true
  # external_nat_ip_ids = "${data.aws_eip.nat.*.id}"

  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true

  tags = {
    Terraform   = "true"
    Environment = "csp1-environment"
    Project     = "csp1-project"
  }
}

# data "aws_eip" "nat" {
#   id = "eipalloc-0d6d436be5ea800f9"
# }