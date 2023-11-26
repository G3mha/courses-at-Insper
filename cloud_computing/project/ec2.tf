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
  user_data                   = base64encode(
    <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt-get update
    sudo apt-get install ec2-instance-connect
    sudo apt install -y python3-pip
    cd Gym-Bros
    rm .env
    export DB_HOST="${aws_db_instance.enricco-rds_instance.endpoint}"
    export DB_USERNAME="${var.username}"
    export DB_PASSWORD="${var.password}"
    export DB_PORT="3306"
    export DB_NAME="${var.db_name}"
    pip install -r requirements.txt
    uvicorn sql_app.main:app
    EOF
  )
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "enricco_launch_template"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = module.vpc.public_subnets[0]
    security_groups             = [aws_security_group.outter_world.id]
  }
}

resource "aws_autoscaling_group" "enricco_asg" {
  desired_capacity     = 2
  min_size             = 2
  max_size             = 6
  vpc_zone_identifier  = module.vpc.public_subnets

  launch_template {
    id      = aws_launch_template.enricco_launch_template.id
    version = "$Latest"
    # define the name of instance as "enricco-instance" + random number
    # name = "enricco-instance"
    # attach public IP to instances
  }
}

resource "aws_autoscaling_policy" "enricco_scale_up_policy" {
  name                   = "enricco_scale_up_policy"
  scaling_adjustment     = 1
  adjustment_type        = var.adjustment_type # ChangeInCapacity
  cooldown               = var.cooldown # 5 minutes
  autoscaling_group_name = aws_autoscaling_group.enricco_asg.name
}

resource "aws_autoscaling_policy" "enricco_scale_down_policy" {
  name                   = "enricco_scale_down_policy"
  scaling_adjustment     = -1
  adjustment_type        = var.adjustment_type # ChangeInCapacity
  cooldown               = var.cooldown # 5 minutes
  autoscaling_group_name = aws_autoscaling_group.enricco_asg.name
}

resource "aws_cloudwatch_metric_alarm" "enricco_high_cpu_alarm" {
  alarm_name          = "enricco_high_cpu_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = 70
  alarm_description   = "This metric monitors ec2 high cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.enricco_scale_up_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.enricco_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "enricco_low_cpu_alarm" {
  alarm_name          = "enricco_low_cpu_alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = 20
  alarm_description   = "This metric monitors ec2 low cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.enricco_scale_down_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.enricco_asg.name
  }
}
