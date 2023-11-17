# modules/rds/outputs.tf

output "RDS_security_group_id" {
  description = "The endpoint of security group that allows access from the instance to the RDS"
  value       = aws_security_group.to_rds.id
}
