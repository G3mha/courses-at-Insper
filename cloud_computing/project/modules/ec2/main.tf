# modules/ec2/main.tf

provider "aws" {
  region = var.region
}

module "security_group" {
  source = "./security_group"
  # Parâmetros do módulo Security Group
}

resource "aws_launch_configuration" "my_launch_config" {
  name_prefix                 = var.launch_config_name
  image_id                    = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = var.security_groups
  user_data                   = var.user_data
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_asg" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnets
  launch_configuration = aws_launch_configuration.my_launch_config.id
}


resource "aws_autoscaling_group" "" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = [var.private_sub1_id, var.private_sub2_id]  # Assuming these are your private subnets

   # Connect to the target group
  target_group_arns = [var.target_group_arn]
  launch_template {
    id = aws_launch_template.ec2_launch_templ.id
    version = "$Latest"  # Use specific version or $Latest for the latest version of the template
  }

}