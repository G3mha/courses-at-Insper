resource "aws_security_group" "to_rds" {
  name        = "to_rds"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

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

# Create security group that allows access from 0.0.0.0/0 to port 22 and 80
resource "aws_security_group" "outter_world" {
  name        = "outter_world"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "outter_world"
  }
}
