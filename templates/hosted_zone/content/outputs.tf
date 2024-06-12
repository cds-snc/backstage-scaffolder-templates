output "hosted_zone_id" {
    description = "Route53 hosted zone ID that will hold our DNS records"
    value       = aws_route53_zone.${{ values.product_name}}.zone_id
  }