resource "aws_key_pair" "key_pair" {
  key_name   = "enricco-key-pair"
  public_key = file("./id_mykey.pub")
}

resource "aws_launch_template" "launch_template" {
  name_prefix                 = "enricco-launch-template"
  image_id                    = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  user_data = base64encode(templatefile("user_data.tftpl", {db_host=aws_db_instance.rds_instance.address, db_name = var.db_name, db_username = var.db_username, db_password = var.db_password}))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "enricco-launch-template"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = module.vpc.public_subnets[0]
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "enricco-asg"
  desired_capacity     = 2
  min_size             = 2
  max_size             = 6
  vpc_zone_identifier  = module.vpc.public_subnets
  target_group_arns    = [aws_alb_target_group.alb_tg.arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "enricco-scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = var.adjustment_type # ChangeInCapacity
  cooldown               = var.cooldown # 5 minutes
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "enricco-scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = var.adjustment_type # ChangeInCapacity
  cooldown               = var.cooldown # 5 minutes
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_policy" "alb_policy" {
  name                      = "enricco-alb-policy"
  autoscaling_group_name    = aws_autoscaling_group.asg.name
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 300 # 5 minutes

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      # Use the load balancer id
      resource_label         = "${split("/", aws_alb.alb.id)[1]}/${split("/", aws_alb.alb.id)[2]}/${split("/", aws_alb.alb.id)[3]}/targetgroup/${split("/", aws_alb_target_group.alb_tg.arn)[1]}/${split("/", aws_alb_target_group.alb_tg.arn)[2]}"
    }

    target_value = 150 # 150 requests per minute
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "enricco-high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = 70
  alarm_description   = "This metric monitors ec2 high cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_up_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_alarm" {
  alarm_name          = "enricco-low-cpu-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = 20
  alarm_description   = "This metric monitors ec2 low cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_down_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "/enricco-fastapi/logs"
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn   = aws_alb_target_group.alb_tg.arn
}
