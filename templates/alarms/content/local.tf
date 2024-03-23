locals {
    api_cloudwatch_log_group = ${{ values.cloudwatch_log_group | dump }} 
    error_logged             = "SystemErrorLogged"
    error_namespace          = "SystemErrorNamespace"
    warning_logged           = "SystemWarningLogged"
  }