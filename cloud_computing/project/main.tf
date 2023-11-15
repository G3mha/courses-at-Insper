provider "aws" {
  region = "us-east-1"
}

# terraform {
#   backend "s3" {
#     bucket = "seu-bucket-s3"
#     key    = "terraform.tfstate"
#     region = "sua-regiao-da-aws"
#   }
# }

# module "ec2" {
#   source = "./modules/ec2"
#   # Parâmetros do módulo EC2
# }

module "rds" {
  source = "./modules/rds"
  # Parâmetros do módulo RDS
  # username and password are set as environment variables
  username = var.username
  password = var.password
}

# module "alb" {
#   source = "./modules/alb"
#   # Parâmetros do módulo ALB
# }
