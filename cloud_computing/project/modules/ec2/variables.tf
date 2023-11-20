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
  default     = base64encode("echo 'Hello, World!' > index.html && nohup python -m SimpleHTTPServer 80 &")
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
