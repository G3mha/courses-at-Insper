# modules/rds/outputs.tf

output "OW_security_group_id" {
  description = "The endpoint of security group that allows access from outter world"
  value       = aws_security_group.outter_world.id
}
