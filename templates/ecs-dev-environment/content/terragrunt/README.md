# Terragrunt structure for ECS Dev Environment

This directory structure provides the foundational AWS infrastructure for an ECS development environment:

    aws/
    │
    ├── ecr/
    │   ├── input.tf
    │   ├── main.tf
    │   └── output.tf
    │
    ├── hosted_zone/
    │   ├── input.tf
    │   ├── main.tf
    │   └── output.tf
    │
    └── vpc/
        ├── input.tf
        ├── main.tf
        └── output.tf
    
    env/
    │
    ├── terragrunt.hcl
    ├── common/
    │   ├── common_variables.tf
    │   └── provider.tf
    │
    ├── staging/
    │   ├── env_vars.hcl
    │   ├── ecr/
    │   │   └── terragrunt.hcl
    │   ├── hosted_zone/
    │   │   └── terragrunt.hcl
    │   └── vpc/
    │       └── terragrunt.hcl
    │
    └── production/
        ├── env_vars.hcl
        ├── ecr/
        │   └── terragrunt.hcl
        ├── hosted_zone/
        │   └── terragrunt.hcl
        └── vpc/
            └── terragrunt.hcl


## Infrastructure Components

This template includes three foundational AWS services:

- **ECR (Elastic Container Registry)**: Container image registry for storing Docker images used by ECS services. Configured with lifecycle policies for image management.
- **Hosted Zone (Route53)**: DNS management for domain configuration, including health checks for production environments.
- **VPC (Virtual Private Cloud)**: Network infrastructure using the official CDS terraform module for secure, isolated networking.

Each AWS service directory contains the following Terraform files:

- `input.tf`: This file defines input variables that are used to parameterize the Terraform configurations. These variables allow you to pass different values for different environments.`:
- `main.tf`: This file contains the core Terraform code that defines the resources you want to create in AWS.
- `output.tf`: This file defines output variables that Terraform will return after applying the configuration. Outputs are useful for returning information about the resources created.

Additional files:
- `env/terragrunt.hcl`: Root Terragrunt configuration file defining common settings, remote state configuration, and shared configurations across all environments and services.
- `env/common/`: Shared Terraform configurations including common variables and provider settings used across all environments.
- Environment-Specific `terragrunt.hcl` Files: Each environment (staging, production) has its own set of Terragrunt configuration files, organized by service. These files can override variables and settings specific to the environment.
- `env_vars.hcl`: Environment-specific variables that customize infrastructure settings (e.g., instance sizes, availability zones) for staging vs production.


### Benefits of This Structure
- **DRY (Don't Repeat Yourself)**: By using Terragrunt, you can define your infrastructure code once and reuse it across multiple environments with different configurations.
- **Modularization**: Each service (ECR, hosted zone, VPC) has its own directory, making it easier to manage and understand the configurations for each part of your infrastructure.
- **Environment Isolation**: Different environments (staging, production) have their own configurations, ensuring that changes in one environment do not affect others.
- **Centralized State Management**: Using remote state configuration in the root terragrunt.hcl ensures that the state files are stored in a central location, typically in an S3 bucket, making it easier to manage and share state.
- **CDS Standards Compliance**: Uses official CDS terraform modules where available (VPC module) ensuring alignment with organizational best practices.

### Environment Configuration
- **Staging**: Cost-optimized configuration with single AZ and minimal NAT gateways
- **Production**: High-availability configuration with multiple AZs and full redundancy