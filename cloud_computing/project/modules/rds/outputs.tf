# modules/rds/outputs.tf

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.my_rds_instance.endpoint
}
