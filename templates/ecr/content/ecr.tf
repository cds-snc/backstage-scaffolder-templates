resource "aws_ecr_repository" "${{ values.product_name }}_ecr" {
  name                 = "${{values.product_name }}_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    CostCentre = ${{ values.billing_code | dump }}
    Terraform  = true
  }
}

resource "aws_ecr_lifecycle_policy" "${{ values.product_name }}_expire_untagged" {
  repository = aws_ecr_repository.${{ values.product_name }}_ecr.name
  policy = jsonencode({
    "rules" : [
      {
        "rulePriority" : 1,
        "description" : "Expire untagged images older than 14 days",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 14
        },
        "action" : {
          "type" : "expire"
        }
      },
      {
        "rulePriority" : 2,
        "description" : "Keep last 20 tagged images",
        "selection" : {
          "tagStatus" : "tagged",
          "tagPrefixList" : ["latest"],
          "countType" : "imageCountMoreThan",
          "countNumber" : 20
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}
