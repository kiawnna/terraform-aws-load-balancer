output "load_balancer_arn" {
  value = aws_lb.ALB.arn
}
output "load_balancer_id" {
  value = aws_lb.ALB.id
}
output "lb_dns_name" {
  value = aws_lb.ALB.dns_name
}
output "lb_zone_id" {
  value = aws_lb.ALB.zone_id
}
output "listener_443_arn" {
  value = var.create_listeners == true ? aws_lb_listener.https[0].arn : null
}
output "load_balancer_arn_suffix" {
  value = aws_lb.ALB.arn_suffix
}