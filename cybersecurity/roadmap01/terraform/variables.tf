// ==== Main Variables

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}

// ==== VPC Variables

variable "private_subnets" {
  type        = list(string)
  description = "Private subnets"
  default     = ["172.31.0.0/26", "172.31.0.64/26"]
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnets"
  default     = ["172.31.0.128/26", "172.31.0.192/26"]
}

// ==== EC2 Variables

variable "ami_id" {
  description = "ID of the Amazon Machine Image (AMI)"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}
