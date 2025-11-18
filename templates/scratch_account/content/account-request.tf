{%- set firstNameTitle = values.first_name | title -%}
{%- set lastNameTitle = values.last_name | title -%}
{%- set firstNameLower = values.first_name | lower -%}
{%- set lastNameLower = values.last_name | lower -%}
{%- set moduleName = firstNameTitle + '_' + lastNameTitle -%}
{%- set accountName = firstNameTitle + lastNameTitle + '-scratch' -%}
{%- set accountEmail = 'aws-cloud-pb-ct+' + firstNameLower + '-' + lastNameLower + '@cds-snc.ca' -%}
{%- set accountAlias = 'cds-snc-' + firstNameLower + '-' + lastNameLower + '-scratch' -%}
module ${{ moduleName }} {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = ${{ accountEmail }}
    AccountName               = ${{ accountName }}
    ManagedOrganizationalUnit = "Sandbox"
    SSOUserEmail              = ${{ values.email_address }}
    SSOUserFirstName          = ${{ firstNameTitle }}
    SSOUserLastName           = ${{ lastNameTitle }}
  }

  account_tags = {
    env           = local.scratch
    business_unit = local.${{ values.business_unit}}
    product       = local.scratch
    ssc_cbrid     = local.cds_cbrid
  }

  change_management_parameters = {
    change_requested_by = ${{ values.requested_by | dump }}
    change_reason       = "Create new scratch account via Backstage template"
  }

  custom_fields = {
    account_alias = ${{ accountAlias }}
  }

  account_customizations_name = "scratch"
}

# Assign permission sets to the group for this account
{%- for permission_set in values.permission_sets %}
resource "aws_ssoadmin_account_assignment" "{{ moduleName | lower }}_{{ permission_set | lower }}" {
  instance_arn       = local.sso_instance_arn
  permission_set_arn = local.permission_set_{{ permission_set | lower }}_arn
  
  principal_id   = local.group_{{ values.group_name | lower }}_id
  principal_type = "GROUP"
  
  target_id   = module.{{ moduleName }}.account_id
  target_type = "AWS_ACCOUNT"
  
  depends_on = [module.{{ moduleName }}]
}
{%- endfor %}
{%- endif %}