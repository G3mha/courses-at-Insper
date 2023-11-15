# modules/rds/main.tf

provider "aws" {
  region = var.region
}

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
  # vpc_security_group_ids = var.security_group_ids
  publicly_accessible    = false
  skip_final_snapshot    = true 
  tags = {
    Name = var.db_instance_identifier
  }
}
