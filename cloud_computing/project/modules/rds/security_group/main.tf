resource "aws_security_group" "to_rds" {
  name        = "to_rds"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["172.31.0.0/16"] # TODO: add the cidr block of the instance that will access the RDS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["172.31.0.0/16"] # TODO: add the cidr block of the instance that will access the RDS
  }

  tags = {
    Name = "to_rds"
  }
}
