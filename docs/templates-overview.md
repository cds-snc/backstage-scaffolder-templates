# Templates Overview

This document provides a detailed overview of all available templates in the Backstage Scaffolder Templates repository.

## Template Categories

Our templates are organized into several categories based on their purpose:

### Infrastructure Templates
Templates for creating AWS infrastructure components using Terraform and Terragrunt.

### Application Templates
Templates for creating complete application setups with CI/CD pipelines.

### Documentation Templates
Templates for bootstrapping documentation projects.

### Configuration Templates
Templates for adding standard configurations to existing projects.

---

## Available Templates

### ECS Dev Environment
**Purpose**: Creates a complete ECS development environment with foundational AWS infrastructure.

**What it creates**:
- ECR (Elastic Container Registry) for storing Docker images
- VPC (Virtual Private Cloud) using CDS terraform modules
- Route53 hosted zones for DNS management
- Terragrunt directory structure
- GitHub Actions workflows
- Dev container configuration

**Use case**: Setting up a new containerized application environment with all necessary AWS infrastructure.

**Tags**: `terraform`, `terragrunt`, `ecs`, `dev-environment`, `aws`, `ecr`, `vpc`, `hosted-zone`

---

### Simple Static Website
**Purpose**: Creates a static website hosted on AWS with S3 and CloudFront.

**What it creates**:
- S3 bucket for static file hosting
- CloudFront distribution for CDN
- Terraform/Terragrunt infrastructure code
- GitHub repository setup
- CI/CD pipeline for deployment

**Use case**: Quickly deploy a static website or documentation site with AWS best practices.

**Tags**: `static-website`, `s3`, `cloudfront`, `terraform`

---

### Lambda Container
**Purpose**: Creates an AWS Lambda function using container images.

**What it creates**:
- Lambda function configuration
- ECR repository for container images
- IAM roles and permissions
- Terraform infrastructure code

**Use case**: Deploying serverless applications using containerized Lambda functions.

**Tags**: `lambda`, `serverless`, `container`, `aws`

---

### S3 Bucket
**Purpose**: Creates an S3 bucket with Terraform/Terragrunt configuration.

**What it creates**:
- S3 bucket with customizable settings
- Bucket policies and permissions
- Lifecycle rules (optional)
- Encryption configuration

**Use case**: Setting up S3 storage for various purposes (data lake, backups, static assets).

**Tags**: `s3`, `storage`, `terraform`, `aws`

---

### VPC
**Purpose**: Creates a VPC using the CDS terraform modules.

**What it creates**:
- VPC with public and private subnets
- Internet Gateway
- NAT Gateways (configurable)
- Route tables
- Network ACLs

**Use case**: Establishing network infrastructure for AWS resources.

**Tags**: `vpc`, `networking`, `terraform`, `aws`

---

### ECR Repository
**Purpose**: Creates an Elastic Container Registry repository.

**What it creates**:
- ECR repository with naming conventions
- Lifecycle policies for image management
- Repository policies
- Scanning configuration

**Use case**: Setting up container image storage for Docker images.

**Tags**: `ecr`, `containers`, `docker`, `terraform`, `aws`

---

### ECS Service
**Purpose**: Creates an ECS service configuration.

**What it creates**:
- ECS task definition
- ECS service
- Load balancer target groups
- Auto-scaling configuration

**Use case**: Deploying containerized applications on ECS.

**Tags**: `ecs`, `containers`, `terraform`, `aws`

---

### Hosted Zone (Route53)
**Purpose**: Creates a Route53 hosted zone for DNS management.

**What it creates**:
- Route53 hosted zone
- Health checks (optional)
- DNS records configuration templates

**Use case**: Managing DNS for your domain or subdomain.

**Tags**: `route53`, `dns`, `terraform`, `aws`

---

### CloudWatch Alarms
**Purpose**: Creates CloudWatch alarms for monitoring AWS resources.

**What it creates**:
- CloudWatch alarm configurations
- SNS topic for notifications
- Alarm actions

**Use case**: Setting up monitoring and alerting for AWS infrastructure.

**Tags**: `cloudwatch`, `monitoring`, `alarms`, `terraform`, `aws`

---

### Spend Notifier
**Purpose**: Creates a budget and cost notification system.

**What it creates**:
- AWS Budgets configuration
- SNS notifications for cost thresholds
- Lambda function for custom alerts

**Use case**: Monitoring and controlling AWS spending.

**Tags**: `budget`, `cost`, `monitoring`, `terraform`, `aws`

---

### Documentation Site
**Purpose**: Creates a documentation project with MkDocs and TechDocs.

**What it creates**:
- MkDocs configuration
- Documentation structure
- Catalog info for Backstage
- GitHub Actions for TechDocs publishing

**Use case**: Creating technical documentation that integrates with Backstage TechDocs.

**Tags**: `documentation`, `mkdocs`, `techdocs`

---

### Terragrunt Bootstrap
**Purpose**: Bootstraps a repository with Terragrunt structure.

**What it creates**:
- Terragrunt directory structure
- Environment-specific configurations (staging, production)
- Common Terraform modules
- Remote state configuration
- Makefile for common operations

**Use case**: Setting up a new infrastructure repository with Terragrunt best practices.

**Tags**: `terragrunt`, `terraform`, `bootstrap`, `infrastructure`

---

### Project Template
**Purpose**: Creates a basic project structure with standard files.

**What it creates**:
- README.md
- LICENSE
- CONTRIBUTING.md
- SECURITY.md
- Basic project structure

**Use case**: Starting a new project with standard documentation and structure.

**Tags**: `project`, `bootstrap`, `template`

---

### Renovate Configuration
**Purpose**: Adds Renovate bot configuration to a project.

**What it creates**:
- renovate.json configuration file
- Customizable update schedules
- Dependency grouping rules

**Use case**: Automating dependency updates in your project.

**Tags**: `renovate`, `dependencies`, `automation`

---

### Branch Protection
**Purpose**: Adds branch protection rules configuration.

**What it creates**:
- Terraform configuration for GitHub branch protection
- Customizable protection rules
- Required status checks

**Use case**: Enforcing code review and CI/CD requirements on important branches.

**Tags**: `github`, `branch-protection`, `terraform`, `security`

---

## Choosing the Right Template

### For New Infrastructure Projects
Start with **Terragrunt Bootstrap** to set up the repository structure, then add specific infrastructure templates like **VPC**, **ECR**, or **ECS**.

### For New Applications
Use **ECS Dev Environment** for containerized applications or **Lambda Container** for serverless applications.

### For Static Content
Use **Simple Static Website** for documentation sites or marketing pages.

### For Existing Projects
Add **Renovate Configuration** or **Branch Protection** to enhance existing repositories.

### For Documentation
Use **Documentation Site** to create TechDocs-compatible documentation.

---

## Template Conventions

All templates follow these conventions:

1. **Naming**: Use lowercase with hyphens (kebab-case)
2. **Structure**: Each template has a `template.yaml` and a `content/` directory
3. **Parameters**: Required parameters are clearly marked in the template form
4. **Outputs**: Templates provide links to created resources (PRs, repositories, etc.)
5. **Tags**: Consistently tagged for easy discovery in Backstage

---

## Next Steps

- [Creating Your Own Template](creating-templates.md)
- [Template Best Practices](best-practices.md)
- [Contributing Guide](../README.md#contributing)
