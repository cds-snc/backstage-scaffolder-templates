output "hosted_zone_id" {
  description = "The hosted zone ID"
  value       = aws_route53_zone.${var.product_name}_hosted_zone.zone_id
}

output "hosted_zone_arn" {
  description = "The ARN of the hosted zone"
  value       = aws_route53_zone.${var.product_name}_hosted_zone.arn
}

output "name_servers" {
  description = "The name servers for the hosted zone"
  value       = aws_route53_zone.${var.product_name}_hosted_zone.name_servers
}

output "domain_name" {
  description = "The domain name of the hosted zone"
  value       = aws_route53_zone.${var.product_name}_hosted_zone.name
}

output "health_check_id" {
  description = "The ID of the health check (if created)"
  value       = var.env == "production" ? aws_route53_health_check.${var.product_name}_health_check[0].id : null
}
