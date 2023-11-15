# modules/ec2/variables.tf

variable "region" {
  description = "AWS region"
  
}

variable "launch_config_name" {
  description = "Name for the launch configuration"
}

variable "ami_id" {
  description = "ID of the Amazon Machine Image (AMI)"
}

variable "instance_type" {
  description = "Type of EC2 instance"
}

variable "key_name" {
  description = "Name of the key pair to use for the instance"
}

variable "security_groups" {
  description = "List of security group IDs for the instance"
}

variable "user_data" {
  description = "User data script for configuring the instance"
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
}

variable "subnets" {
  description = "List of subnet IDs for the Auto Scaling Group"
}
