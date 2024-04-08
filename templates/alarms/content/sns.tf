#
# SNS: topic & subscription
#
resource "aws_sns_topic" "cloudwatch_warning" {
  name = "cloudwatch-alarms-warning"

  tags = {
    CostCentre = ${{ values.billing_tag_value | dump}} 
    Terraform  = true
  }
}

resource "aws_sns_topic_subscription" "alert_warning" {
  topic_arn = aws_sns_topic.cloudwatch_warning.arn
  protocol  = "https"
  endpoint  = ${{ values.slack_webhook_url | dump}} 
}