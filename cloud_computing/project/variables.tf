variable "username" {
  description = "Master username for the DB instance"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Master password for the DB instance"
  type        = string
  sensitive   = true
}

variable "user_data" {
  description = "User data script for configuring the instance"
  type        = string
  default     = "uvicorn sql_app.main:app"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "db_instance_identifier" {
  description = "DB instance identifier"
  type        = string
  default     = "myrdsdb"
}