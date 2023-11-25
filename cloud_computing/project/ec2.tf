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
  user_data                   = base64encode(var.user_data)
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
  vpc_zone_identifier  = module.vpc.public_subnets

  launch_template {
    id      = aws_launch_template.enricco_launch_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "enricco_scale_up_policy" {
  name                   = "enricco_scale_up_policy"
  scaling_adjustment     = 1
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.enricco_asg.name
}

resource "aws_autoscaling_policy" "enricco_scale_down_policy" {
  name                   = "enricco_scale_down_policy"
  scaling_adjustment     = -1
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown
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
