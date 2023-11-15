# modules/alb/outputs.tf

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.my_alb.dns_name
}
