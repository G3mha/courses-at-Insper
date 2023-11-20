# modules/ec2/main.tf

provider "aws" {
  region = var.region
}

module "security_group" {
  source = "./security_group"
}

resource "tls_private_key" "enricco_key_pair" {
  algorithm = "RSA"
}

resource "aws_key_pair" "enricco_aws_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.enricco_key_pair.public_key_openssh
  depends_on = [ tls_private_key.enricco_key_pair ]
}

resource "aws_launch_template" "enricco_launch_template" {
  name_prefix                 = var.launch_template_name
  image_id                    = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.enricco_aws_key_pair.key_name
  vpc_security_group_ids      = [module.security_group.OW_security_group_id]
  user_data                   = var.user_data
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "enricco_launch_template"
    }
  }
}

resource "aws_autoscaling_group" "enricco_asg" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  launch_template {
    id      = aws_launch_template.enricco_launch_template.id
    version = "$Latest"
  }
}
