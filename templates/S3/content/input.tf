variable "billing_code" {
    description = "The billing code to use for cost allocation (Required)"
    type        = string
  }
  
  variable "billing_tag_key" {
    description = "The billing tag to use for cost allocation. (Optional, default value is "CostCenter")"
    type        = string
  }

  variable "block_public_acls" {
    description = "Rejects access to create public ACLs. (Optional, default value is "true")"
    type        = string
  }

  variable "block_public_policy" {
    description = "Reject requests to add Bucket policy if the specified bucket policy allows public access. (Optional, default value is "true")"
    type        = string
  }

  variable "bucket_name" {
    description = "The name of the bucket. If omitted, Terraform will assign a random, unique name. (Optional, forces new resource)"
    type        = string
  }

  variable "bucket_prefix" {
    description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. (Optional, forces new resource)"
    type        = string
  }

  variable "critical_tag_key" {
    description = "The name of the critical tag. (Optional, default value is "Critical")"
    type        = string
  }

  variable "critical_tag_value" {
    description = "The value of the critical tag. If set to true, protection SCP rules will be applied to the resource. (Required, default value is "false")"
    type        = string
  }

  variable "force_destroy" {
    description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. (Optional, default value is "false")"
    type        = string
  }

  variable "ignore_public_acls" {
    description = "Ignore public ACLs on this bucket and any objects that it contains. (Optional, default value is "true")"
    type        = string
  }
  variable "kms_key_arn" {
    description = "KMS key ARN that will be used to encrypt S3 objects. If not specified, default S3 service key is used for encryption. (Optional)"
    type        = string
  }
  variable "lifecycle_rule" {
    description = "List of maps containing configuration of object lifecycle management. (Optional)"
    type        = string
  }
  variable "logging" {
    description = "Map containing access bucket logging configuration.
    target_bucket: name of the bucket to log to.
    target_prefix: prefix to use when logging. (Optional)"
    type        = string
  }
  variable "object_lock_configuration" {
    description = "Map containing S3 object locking configuration. (Optional, forces new resource)"
    type        = string
  }
  variable "replication_configuration" {
    description = "Map containing cross-region replication configuration. (Optional)"
    type        = string
  }
  variable "restrict_public_buckets" {
    description = "Only the bucket owner and AWS Services can access this buckets if it has a public policy. (Optional, default value is "true")"
    type        = string
  }
  variable "tags" {
    description = "A mapping of tags to assign to the bucket. (Optional)"
    type        = string
  }
  variable "versioning" {
    description = "Map containing versioning configuration. (Optional)"
    type        = string
  }