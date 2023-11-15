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
