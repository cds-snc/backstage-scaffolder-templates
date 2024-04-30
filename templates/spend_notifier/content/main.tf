module "spend_notifier" {
    source                           = "github.com/cds-snc/terraform-modules//vpc?ref=v9.3.1"
    daily_spend_notifier_hook        = var.daily_spend_notifier_hook
    weekly_spend_notifier_hook       = var.weekly_spend_notifier_hook 
    billing_tag_value                = ${{ values.billing_tag_value | dump}} 
    account_name                     = ${{ values.account_name | dump}} 
    enable_weekly_spend_notification = ${{ values.create_weekly_notification| dump}}
    enable_daily_spend_notification  = ${{ values.create_daily_notification| dump}} 
    weekly_schedule_expression       = ${{ values.weekly_schedule_expression | dump}} 
    daily_schedule_expression        = ${{ values.daily_schedule_expression | dump}} 
}