resource "aws_db_instance" "enricco-rds_instance" {
  identifier              = "myrdsdb"
  db_name                 = "mydb"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0.33"
  instance_class          = "db.t2.micro"
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.enricco-db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.to_rds.id]

  backup_retention_period = 7
  backup_window           = "04:00-05:00"
  maintenance_window      = "Mon:03:00-Mon:04:00"

  multi_az                = true
  publicly_accessible     = false
  skip_final_snapshot     = true 
  tags = {
    Name = "myrdsdb"
  }
}

resource "aws_db_subnet_group" "enricco-db_subnet_group" {
  name       = "enricco-myrdsdb"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "MyDBSubnetGroup"
  }
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.enricco-rds_instance.endpoint
}