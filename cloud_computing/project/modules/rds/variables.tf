# modules/rds/variables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
  default     = "myrdsdb"
}

variable "allocated_storage" {
  description = "The amount of allocated storage in gibibytes"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "The storage type for the DB instance"
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "The name of the database engine to be used for the DB instance"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The version number of the database engine to be used"
  type        = string
  default     = "8.0.33"
}

variable "instance_class" {
  description = "The instance class of the RDS instance"
  type        = string
  default     = "db.t2.micro"
}

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

variable "maintenance_window" {
  description = "The window to perform backup in"
  type        = string
  default     = "Mon:03:00-Mon:04:00"
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "03:00-04:00"
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for"
  type        = number
  default     = 7
}

# variable "db_subnet_group_name" {
#   description = "Name of DB subnet group"
# }

# variable "security_group_ids" {
#   description = "List of security group IDs for the RDS instance"
# }
