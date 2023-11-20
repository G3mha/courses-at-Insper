# modules/alb/main.tf

provider "aws" {
  region = var.region
}

module "security_group" {
  source = "./security_group"
}

resource "aws_lb" "enricco_alb" {
  name               = var.alb_name
  internal           = var.internal # the ALB is not internal
  load_balancer_type = var.lb_type
  security_groups    = [module.security_group.OW_security_group_id]
}

resource "aws_lb_target_group" "enricco_target_group" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    port                = var.target_group_port
    protocol            = var.target_group_protocol
    timeout             = var.timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
}

resource "aws_lb_target_group_attachment" "enricco_target_group_attachment" {
  target_group_arn = aws_lb_target_group.enricco_target_group.arn
  target_id        = aws_instance.enricco_ec2_instance.id
  port             = var.target_group_port
}

# resource "aws_lb_listener" "my_listener" {
#   load_balancer_arn = aws_lb.my_alb.arn
#   port              = var.listener_port
#   protocol          = var.listener_protocol

#   default_action {
#     target_group_arn = aws_lb_target_group.my_target_group.arn
#     type             = "fixed-response"

#     fixed_response {
#       content_type = "text/plain"
#       status
#     }
#   }
# }