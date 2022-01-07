resource "aws_lb" "ALB" {
  name               = "shared-${var.environment}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = {
   Name = "shared-${var.environment}-alb"
   Deployment_Method = "terraform"
   Environment = var.environment
  }
}

resource "aws_lb_cookie_stickiness_policy" "sticky_policy" {
  count = var.add_sticky_policy ? 1 : 0
  name                     = "sticky-policy-${var.environment}"
  load_balancer            = aws_lb.ALB.id
  lb_port                  = 443
  cookie_expiration_period = 10080
}

resource "aws_lb_listener" "http" {
  count = var.create_listeners ? 1 : 0
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  count = var.create_listeners ? 1 : 0
  load_balancer_arn = aws_lb.ALB.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.cert_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Please request traffic using a valid DNS name."
      status_code  = "200"
    }
  }
}