terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

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


module "rds" {
  source = "./modules/rds"
  # Parâmetros do módulo RDS
  username = var.username
  password = var.password
}

module "ec2" {
  source = "./modules/ec2"
  # Parâmetros do módulo EC2
  user_data = base64encode(var.user_data)
}

module "alb" {
  source = "./modules/alb"
  # Parâmetros do módulo ALB
  listener_port = 80
  # Parâmetros do módulo ALB
}
