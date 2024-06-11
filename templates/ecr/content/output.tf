################################################################################
# ECR Repository 
################################################################################

output "ecr_repository_url" {
  description = "URL of the ${{ values.product_name }} ECR"
  value       = aws_ecr_repository.${{ values.product_name }}_ecr.repository_url
}

output "ecr_repository_arn" {
  description = "Arn of the ${{ values.product_name }} ECR Repository"
  value       = aws_ecr_repository.${{ values.product_name }}_ecr.arn
}