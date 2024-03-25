variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "ami_id" {
  description = "ID of the Amazon Machine Image (AMI)"
  type        = string
  default     = "ami-029772b103bf2782f"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
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

variable "alb_name" {
  description = "Name for the Application Load Balancer"
  type        = string
  default     = "enricco_alb"
}

variable "internal" {
  description = "Set to true if the ALB should be internal"
  type        = bool
  default     = false
}

variable "lb_type" {
  description = "Type of the load balancer (application, network, etc.)"
  type        = string
  default     = "application"
}

variable "target_group_name" {
  description = "Name for the target group"
  type        = string
  default     = "enricco_target_group"
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "timeout" {
  description = "Timeout for the health check"
  type        = number
  default     = 5
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "mydb"
}

variable "db_username" {
  description = "Master username for the DB instance"
  type        = string
}

variable "db_password" {
  description = "Master password for the DB instance"
  type        = string
}
