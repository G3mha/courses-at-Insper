# modules/ec2/outputs.tf

output "ec2_instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_autoscaling_group.my_asg.instances[*].id
}
