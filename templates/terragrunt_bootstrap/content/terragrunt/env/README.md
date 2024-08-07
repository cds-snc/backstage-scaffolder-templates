# Environment Configuration

This directory contains the environment-specific Terragrunt configurations for managing AWS infrastructure. Each subdirectory corresponds to a different environment (e.g. `staging`, `prod`) and contains the necessary Terragrunt configuration files for each AWS service.

## Directory Structure

    └── env/
    ├── staging/
    │   ├── cloudfront/
    │   │   └── terragrunt.hcl
    │   ├── s3/
    │   │   └── terragrunt.hcl
    │   ├── ecs/
    │   │   └── terragrunt.hcl
    │   └── rds/
    │       └── terragrunt.hcl
    └── production/
        ├── cloudfront/
        │   └── terragrunt.hcl
        ├── s3/
        │   └── terragrunt.hcl
        ├── ecs/
        │   └── terragrunt.hcl
        └── rds/
            └── terragrunt.hcl

### `terragrunt.hcl`

Each `terragrunt.hcl` file contains the configuration for deploying the corresponding service in that specific environment. This file includes settings and inputs unique to the environment, such as region, environment name, and any other environment-specific variables.

#### Example Configuration

Here are example contents of the `terragrunt.hcl` files for the `staging` environment for the S3 service:

#### Staging Environment

**File**: `env/staging/s3/terragrunt.hcl`
```
    terraform {
        source = "../../../aws//s3"
    }
    
    include {
        path = find_in_parent_folders()
    }
```

This configuration includes:
- `include` block to inherit common settings from the parent terragrunt.hcl.
- `terraform` block to specify the source path for the Terraform configuration.