  module "S3" {
    source = "github.com/cds-snc/terraform-modules//S3?ref=v9.2.4"
  
    billing_tag_key = var.billing_tag_key
    billing_tag_value  = var.billing_code
    bucket_name = var.bucket_name
    block_public_acls = var.block_public_acls
    block_public_policy = var.block_public_policy
    bucket_prefix = var.bucket_prefix
    critical_tag_key = var.critical_tag_key
    critical_tag_value = var.critical_tag_value
    force_destroy = var.force_destroy
    ignore_public_acls = var.ignore_public_acls
    kms_key_arn = var.kms_key_arn
    lifecycle_rule = var.lifecycle_rule
    logging = var.logging
    object_lock_configuration = var.object_lock_configuration
    replication_configuration = var.replication_configuration
    restrict_public_buckets = var.restrict_public_buckets
    tags = var.tags
    versioning = var.versioning
  }