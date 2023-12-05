resource "aws_instance" "locust" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.locust_sg.id]
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  user_data = base64encode(templatefile("user_data_locust.tftpl", {dns_name = format("%s/%s",aws_alb.alb.dns_name,"docs")}))

  tags = {
      Name = "enricco-locust"
  }
}

# locust will run on port 8089