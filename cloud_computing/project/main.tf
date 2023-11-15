provider "aws" {
  region = "sua-regiao-da-aws"
}

terraform {
  backend "s3" {
    bucket = "seu-bucket-s3"
    key    = "terraform.tfstate"
    region = "sua-regiao-da-aws"
  }
}

module "ec2" {
  source = "./modules/ec2"
  # Parâmetros do módulo EC2
}

module "rds" {
  source = "./modules/rds"
  # Parâmetros do módulo RDS
}

module "alb" {
  source = "./modules/alb"
  # Parâmetros do módulo ALB
}
