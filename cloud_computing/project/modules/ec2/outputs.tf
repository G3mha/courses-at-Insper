# modules/ec2/outputs.tf

# Output block to display the IDs of the created EC2 instances
output "ec2_instance_ids" {
  value = aws_autoscaling_group.enricco_asg.instances[*].id
}