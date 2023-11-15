# modules/alb/main.tf

provider "aws" {
  region = var.region
}

resource "aws_lb" "my_alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.lb_type
  security_groups    = var.security_groups
  subnets            = var.subnets
}

resource "aws_lb_target_group" "my_target_group" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol

  health_check {
    path = var.health_check_path
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    type             = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status
