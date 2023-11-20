# Create security group that allows access from 0.0.0.0/0 to port 22 and 80
resource "aws_security_group" "outter_world" {
  name        = "outter_world"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "HTTP"
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
