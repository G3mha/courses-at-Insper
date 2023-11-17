# modules/rds/main.tf

provider "aws" {
  region = var.region
}

# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }

# resource "aws_key_pair" "deployer_key" {
#   key_name   = "ssh_key"
#   public_key = tls_private_key.ssh_key.public_key_openssh
# }

module "security_group" {
  source = "./security_group"
  # Parâmetros do módulo Security Group
}

resource "aws_db_instance" "my_rds_instance" {
  identifier              = var.db_instance_identifier
  db_name                 = var.db_name
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
  # db_subnet_group_name   = var.db_subnet_group_name
  # vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  vpc_security_group_ids = [module.security_group.RDS_security_group_id]

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
