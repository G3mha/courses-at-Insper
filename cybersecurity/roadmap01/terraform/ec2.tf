resource "aws_key_pair" "key_pair" {
  key_name   = "mykeypair"
  public_key = file("~/.ssh/id_rsa_cybersec.pub")
}

resource "aws_launch_template" "wordpress_launch_template" {
  name_prefix   = "csp1-wordpress-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key_pair.key_name
  # TODO: Add user_data
  # user_data = base64encode(templatefile())

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "csp1-wordpress-instance"
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }
}

resource "aws_launch_template" "mysql_launch_template" {
  name_prefix   = "csp1-mysql-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key_pair.key_name
  # TODO: Add user_data
  # user_data = base64encode(templatefile())

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "csp1-mysql-instance"
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }
}

resource "aws_instance" "wordpress_instance" {
  launch_template {
    id = aws_launch_template.wordpress_launch_template.id
  }
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.ec2_sg.id]

}

resource "aws_instance" "mysql_instance" {
  launch_template {
    id = aws_launch_template.mysql_launch_template.id
  }
  subnet_id       = module.vpc.private_subnets[0]
  security_groups = [aws_security_group.ec2_sg.id]
}

resource "aws_eip" "wordpress_eip" {
  instance = aws_instance.wordpress_instance.id

  tags = {
    Name = "csp1-wordpress-eip"
  }
}

resource "aws_eip" "mysql_eip" {
  instance = aws_instance.mysql_instance.id

  tags = {
    Name = "csp1-mysql-eip"
  }
}

resource "aws_eip_association" "wordpress_eip_association" {
  instance_id   = aws_instance.wordpress_instance.id
  allocation_id = aws_eip.wordpress_eip.id
}

resource "aws_eip_association" "mysql_eip_association" {
  instance_id   = aws_instance.mysql_instance.id
  allocation_id = aws_eip.mysql_eip.id
}
