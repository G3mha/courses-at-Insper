resource "aws_alb" "alb" {
  name                             = "enricco-alb"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb_sg.id]
  subnets                          = module.vpc.public_subnets
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "enricco-alb"
  }
}

resource "aws_alb_target_group" "alb_tg" {
  name     = "enricco-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 20
    interval            = 60
    path                = "/"
  }

  tags = {
    Name = "enricco-alb-tg"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_tg.arn
    type             = "forward"
  }
}
