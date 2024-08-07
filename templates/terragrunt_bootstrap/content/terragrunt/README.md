# Terragrunt structure for AWS

Here's an example of a directory structure for organizing your Terraform and Terragrunt configurations:

    aws/
    │
    ├── cloudfront/
    │   ├── input.tf
    │   ├── main.tf
    │   └── output.tf
    │
    ├── s3/
    │   ├── input.tf
    │   ├── main.tf
    │   └── output.tf
    │
    ├── ecs/
    │   ├── input.tf
    │   ├── main.tf
    │   └── output.tf
    │
    ├── rds/
    │   ├── input.tf
    │   ├── main.tf
    │   └── output.tf
    │
    ├── terragrunt.hcl
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


Each AWS service directory contains the following Terraform files:

- `input.tf`: This file defines input variables that are used to parameterize the Terraform configurations. These variables allow you to pass different values for different environments.`:
- `main.tf`: This file contains the core Terraform code that defines the resources you want to create in AWS.
- `output.tf`: This file defines output variables that Terraform will return after applying the configuration. Outputs are useful for returning information about the resources created.

Additional files:
- `env/terragrunt.hcl`: This is the root Terragrunt configuration file. It can define common settings, such as remote state configuration and include common configurations that are shared across all environments and services.
- Environment-Specific `terragrunt.hcl` Files: Each environment (staging, prod) has its own set of Terragrunt configuration files, organized by service. These files can override variables and settings specific to the environment.


### Benefits of This Structure
- **DRY (Don't Repeat Yourself)**: By using Terragrunt, you can define your infrastructure code once and reuse it across multiple environments with different configurations.
- **Modularization**: Each service has its own directory, making it easier to manage and understand the configurations for each part of your infrastructure.
- **Environment Isolation**: Different environments (staging, prod) have their own configurations, ensuring that changes in one environment do not affect others.
- **Centralized State Management**: Using remote state configuration in the root terragrunt.hcl ensures that the state files are stored in a central location, typically in an S3 bucket, making it easier to manage and share state.