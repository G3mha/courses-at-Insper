# modules/ec2/variables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "launch_template_name" {
  description = "Name for the launch configuration"
  type        = string
  default     = "enricco_launch_template"
}

variable "ami_id" {
  description = "ID of the Amazon Machine Image (AMI)"
  type        = string
  default     = "ami-0d86d19bb909a6c95"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair to use for the instance"
  type        = string
  default     = "enricco_key_pair"
}

variable "user_data" {
  description = "User data script for configuring the instance"
  type        = string
  default     = "uvicorn sql_app.main:app"
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 4
}

variable "evaluation_periods" {
  description = "Number of periods to evaluate the metric"
  type        = number
  default     = 1
}

variable "metric_name" {
  description = "Name of the metric to monitor"
  type        = string
  default     = "CPUUtilization"
}

variable "namespace" {
  description = "Namespace of the metric to monitor"
  type        = string
  default     = "AWS/EC2" 
}

variable "period" {
  description = "Period of the metric to monitor"
  type        = number
  default     = 60
}

variable "statistic" {
  description = "Statistic of the metric to monitor"
  type        = string
  default     = "Average"
}

variable "cooldown" {
  description = "Cooldown period for the Auto Scaling Group"
  type        = number
  default     = 300
}

variable "adjustment_type" {
  description = "Adjustment type for the Auto Scaling Group"
  type        = string
  default     = "ChangeInCapacity"
}