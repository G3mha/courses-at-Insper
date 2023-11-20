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