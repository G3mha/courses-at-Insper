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

resource "aws_db_instance" "my_rds_instance" {
  identifier             = var.db_instance_identifier
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = var.password
  # db_subnet_group_name   = var.db_subnet_group_name
  # vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  multi_az               = true
  publicly_accessible    = false
  skip_final_snapshot    = true 
  tags = {
    Name = var.db_instance_identifier
  }
}
