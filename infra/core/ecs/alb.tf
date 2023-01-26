resource "aws_lb_target_group" "this" {
  name_prefix = substr(var.app_name, 0, 6)
  lifecycle {
    create_before_destroy = true
  }
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    enabled = true
    path    = "/"
  }
  depends_on = [
    aws_alb.this
  ]
}

resource "aws_alb" "this" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  security_groups = [
    var.http_security_group_id,
    var.https_security_group_id,
    var.egress_security_group_id
  ]
}

resource "aws_alb_listener" "api_http" {
  load_balancer_arn = aws_alb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
output "alb_url" {
  value = "http://${aws_alb.this.dns_name}"
}
