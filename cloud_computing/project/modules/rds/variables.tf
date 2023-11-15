# modules/rds/variables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
  default     = "my_rds_db"
}

variable "allocated_storage" {
  description = "The amount of allocated storage in gibibytes"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "The storage type for the DB instance"
  type        = string
  default     = "io1" // Designed for applications that require high and consistent I/O performance, such as databases (e.g., MySQL, PostgreSQL) or applications with high-performance requirements.
}

variable "engine" {
  description = "The name of the database engine to be used for the DB instance"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The version number of the database engine to be used"
  type        = string
  default     = "8.0.27"
}

variable "instance_class" {
  description = "The instance class of the RDS instance"
  type        = string
  default     = "db.t3.micro"
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

# variable "db_subnet_group_name" {
#   description = "Name of DB subnet group"
# }

# variable "security_group_ids" {
#   description = "List of security group IDs for the RDS instance"
# }
