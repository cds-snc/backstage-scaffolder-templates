resource "aws_cloudwatch_log_metric_filter" "filter_system_error" {
  name           = local.error_logged
  pattern        = "?ERROR ?Error"
  log_group_name = local.api_cloudwatch_log_group

  metric_transformation {
    name      = local.error_logged
    namespace = local.error_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm_system_error" {
  alarm_name          = "${{ values.service_name}}-Errors"
  alarm_description   = "${{ values.service_name }} errors >= ${{ values.error_threshold }} in 1 minute"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  metric_name        = aws_cloudwatch_log_metric_filter.gc_design_system_error.metric_transformation[0].name
  namespace          = aws_cloudwatch_log_metric_filter.gc_design_system_error.metric_transformation[0].namespace
  period             = "60"
  evaluation_periods = "1"
  statistic          = "Sum"
  threshold          = ${{ values.error_threshold | dump }}
  treat_missing_data = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_warning.arn]
}

resource "aws_cloudwatch_log_metric_filter" "filter_system_warning" {
  name           = local.warning_logged
  pattern        = "?WARNING ?Warning"
  log_group_name = local.api_cloudwatch_log_group

  metric_transformation {
    name      = local.warning_logged
    namespace = local.error_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm_system_warning" {
  alarm_name          = "${{ values.service_name }}-Warning"
  alarm_description   = "${{ values.service_name }} warnings >= ${{ values.warning_threshold }} in 1 minute"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  metric_name        = aws_cloudwatch_log_metric_filter.gc_design_system_warning.metric_transformation[0].name
  namespace          = aws_cloudwatch_log_metric_filter.gc_design_system_warning.metric_transformation[0].namespace
  period             = "60"
  evaluation_periods = "1"
  statistic          = "Sum"
  threshold          = ${{ values.warning_threshold | dump }} 
  treat_missing_data = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_warning.arn]
}