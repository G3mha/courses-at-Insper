# modules/alb/variables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
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

variable "healthy_threshold" {
  description = "Healthy threshold for the health check"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Unhealthy threshold for the health check"
  type        = number
  default     = 2
}

variable "listener_port" {
  description = "Port for the ALB listener"
}

variable "listener_protocol" {
  description = "Protocol for the ALB listener"
  default     = "HTTP"
}
