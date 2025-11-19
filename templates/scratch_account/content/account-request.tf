{%- set firstNameTitle = values.first_name | title -%}
{%- set lastNameTitle = values.last_name | title -%}
{%- set firstNameLower = values.first_name | lower -%}
{%- set lastNameLower = values.last_name | lower -%}
{%- set moduleName = firstNameTitle + '_' + lastNameTitle -%}
{%- set accountName = firstNameTitle + lastNameTitle + '-scratch' -%}
{%- set accountEmail = 'aws-cloud-pb-ct+' + firstNameLower + '-' + lastNameLower + '@cds-snc.ca' -%}
{%- set accountAlias = 'cds-snc-' + firstNameLower + '-' + lastNameLower + '-scratch' -%}
module "${{ moduleName }}" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "${{ accountEmail }}"
    AccountName               = "${{ accountName }}"
    ManagedOrganizationalUnit = "Sandbox"
    SSOUserEmail              = "${{ values.email_address }}"
    SSOUserFirstName          = "${{ firstNameTitle }}"
    SSOUserLastName           = "${{ lastNameTitle }}"
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
    account_alias = "${{ accountAlias }}"
  }

  account_customizations_name = "scratch"
}