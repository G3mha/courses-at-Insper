resource "aws_db_instance" "rds_instance" {
  identifier              = "enricco-rds-instance"
  db_name                 = var.db_name
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0.33"
  instance_class          = "db.t2.micro"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  backup_retention_period = 7
  backup_window           = "04:00-05:00"
  maintenance_window      = "Mon:03:00-Mon:04:00"
  multi_az                = true
  publicly_accessible     = false
  skip_final_snapshot     = true 

  tags = {
    Name = "enricco-rds-instance"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "enricco-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "enricco-db-subnet-group"
  }
}
