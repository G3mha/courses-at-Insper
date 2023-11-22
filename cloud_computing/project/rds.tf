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
  db_name                 = "mydb"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0.33"
  instance_class          = "db.t2.micro"
  username                = var.username
  password                = var.password
  # db_subnet_group_name   = var.db_subnet_group_name
  # vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  vpc_security_group_ids = [module.security_group.RDS_security_group_id]

  backup_retention_period = 7
  backup_window           = "04:00-05:00"
  maintenance_window      = "Mon:03:00-Mon:04:00"

  multi_az                = true
  publicly_accessible     = false
  skip_final_snapshot     = true 
  tags = {
    Name = var.db_instance_identifier
  }
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.my_rds_instance.endpoint
}