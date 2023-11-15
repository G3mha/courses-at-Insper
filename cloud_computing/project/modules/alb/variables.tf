# modules/alb/variables.tf

variable "region" {
  description = "AWS region"
}

variable "alb_name" {
  description = "Name for the Application Load Balancer"
}

variable "internal" {
  description = "Set to true if the ALB should be internal"
  default     = false
}

variable "lb_type" {
  description = "Type of the load balancer (application, network, etc.)"
  default     = "application"
}

variable "security_groups" {
  description = "List of security group IDs for the ALB"
}

variable "subnets" {
  description = "List of subnet IDs for the ALB"
}

variable "target_group_name" {
  description = "Name for the target group"
}

variable "target_group_port" {
  description = "Port for the target group"
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Path for the health check"
  default     = "/"
}

variable "listener_port" {
  description = "Port for the ALB listener"
}

variable "listener_protocol" {
  description = "Protocol for the ALB listener"
  default     = "HTTP"
}
