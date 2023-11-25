resource "aws_alb" "enricco-alb" {
  name               = "enricco-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.outter_world.id]
  subnets            = module.vpc.public_subnets
  tags = {
    Name = "enricco-alb"
  }
}

resource "aws_alb_target_group" "enricco-alb-tg" {
  name     = "enricco-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }
  tags = {
    Name = "enricco-alb-tg"
  }
}

resource "aws_alb_listener" "enricco-alb-listener" {
  load_balancer_arn = aws_alb.enricco-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.enricco-alb-tg.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "enricco-alb-listener-rule" {
  listener_arn = aws_alb_listener.enricco-alb-listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.enricco-alb-tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

