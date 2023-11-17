# modules/rds/main.tf

provider "aws" {
  region = var.region
}

# # Defina o Security Group para o RDS
# resource "aws_security_group" "rds_security_group" {
#   name        = "rds_security_group"
#   description = "Security Group for RDS instances"

#   ingress {
#     from_port       = 3306  # O número da porta para MySQL
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [aws_security_group.ec2_security_group.id]
#   }

#   # Adicione outras regras de ingress conforme necessário
# }


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

# Get the id of the created VPC
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["main"]
  }
}

# Create a security group for the RDS instance that allows access from all EC2 instance within the same VPC
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Security group for RDS instance to allow access from EC2 instances"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "my_rds_instance" {
  identifier              = var.db_instance_identifier
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
  # db_subnet_group_name   = var.db_subnet_group_name
  # vpc_security_group_ids = [aws_security_group.rds_security_group.id]

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  multi_az                = true
  publicly_accessible     = false
  skip_final_snapshot     = true 
  tags = {
    Name = var.db_instance_identifier
  }
}
