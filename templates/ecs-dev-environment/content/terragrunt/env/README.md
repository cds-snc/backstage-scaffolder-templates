# Environment Configuration

This directory contains the environment-specific Terragrunt configurations for managing AWS infrastructure. Each subdirectory corresponds to a different environment (e.g. `staging`, `prod`) and contains the necessary Terragrunt configuration files for each AWS service.

## Directory Structure

    └── env/
    ├── staging/
    │   ├── ecr/
    │   │   └── terragrunt.hcl
    │   ├── hosted_zone/
    │   │   └── terragrunt.hcl
    │   ├── vpc/
    │   │   └── terragrunt.hcl
    │   └── env_vars.hcl
    └── production/
        ├── ecr/
        │   └── terragrunt.hcl
        ├── hosted_zone/
        │   └── terragrunt.hcl
        ├── vpc/
        │   └── terragrunt.hcl
        └── env_vars.hcl

### `terragrunt.hcl`

Each `terragrunt.hcl` file contains the configuration for deploying the corresponding service in that specific environment. This file includes settings and inputs unique to the environment, such as region, environment name, and any other environment-specific variables.

#### Example Configuration

Here are example contents of the `terragrunt.hcl` files for the `staging` environment for the ECR service:

#### Staging Environment

**File**: `env/staging/ecr/terragrunt.hcl`
```
    terraform {
        source = "../../aws/ecr"
    }
    
    include "root" {
        path = find_in_parent_folders()
    }
```

This configuration includes:
- `include` block to inherit common settings from the parent terragrunt.hcl.
- `terraform` block to specify the source path for the Terraform configuration.