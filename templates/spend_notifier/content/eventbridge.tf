resource "aws_cloudwatch_event_rule" "weekly_budget_spend" {
  count               =  ${{ values.create_weekly_notification}} 
  name                = "weeklyBudgetSpend"
  schedule_expression = "cron(${{values.weekly_schedule_expression}})"

  tags = local.common_tags
}

resource "aws_cloudwatch_event_target" "weekly_budget_spend" {
  count = ${{ values.create_weekly_notification }}
  rule  = aws_cloudwatch_event_rule.weekly_budget_spend[0].name
  arn   = aws_lambda_function.spend_notifier.arn
  input = jsonencode({
    "hook" = "${var.weekly_spend_notifier_hook}"
    }
  )
}

resource "aws_cloudwatch_event_rule" "daily_budget_spend" {
  count               = ${{ values.create_daily_notification}} 
  name                = "dailyBudgetSpend"
  schedule_expression = "cron(${{values.daily_schedule_expression}})"

  tags = local.common_tags
}


resource "aws_cloudwatch_event_target" "daily_budget_spend" {
  count = ${{ values.create_daily_notification}}
  rule  = aws_cloudwatch_event_rule.daily_budget_spend[0].name
  arn   = aws_lambda_function.spend_notifier.arn
  input = jsonencode({
    "hook" = "${var.daily_spend_notifier_hook}"
  })
}