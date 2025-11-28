# Template Best Practices

This guide outlines best practices for creating, maintaining, and using Backstage scaffolder templates.

## Design Principles

### Keep It Simple

✅ **Good**: A template that creates one thing well
```yaml
metadata:
  name: s3-bucket
  title: Create S3 Bucket
  description: Creates a single S3 bucket with standard configuration
```

❌ **Bad**: A template that tries to do everything
```yaml
metadata:
  name: complete-infrastructure
  title: Create Everything
  description: Creates S3, RDS, ECS, Lambda, and more
```

**Why**: Simple templates are easier to understand, maintain, and debug. Users can combine multiple simple templates rather than navigate a complex one.

### Be Opinionated But Flexible

Provide sensible defaults while allowing customization:

```yaml
parameters:
  properties:
    bucket_name:
      title: Bucket Name
      type: string
      description: Name for your S3 bucket
    
    enable_versioning:
      title: Enable Versioning
      type: boolean
      default: true  # Opinionated default
      description: Recommended for production use
    
    lifecycle_rules:
      title: Lifecycle Rules
      type: string
      enum:
        - standard
        - glacier-transition
        - none
      default: standard
```

### Follow Organizational Standards

Templates should enforce your organization's standards:

- Naming conventions
- Security requirements
- Tagging policies
- Monitoring setup
- Cost management

## Template Structure Best Practices

### Metadata

#### Naming
```yaml
# ✅ Good: Clear, descriptive, kebab-case
metadata:
  name: ecs-fargate-service
  title: Create ECS Fargate Service

# ❌ Bad: Vague, inconsistent
metadata:
  name: createService
  title: service template
```

#### Descriptions
```yaml
# ✅ Good: Detailed, explains what it creates
description: |
  Creates an ECS Fargate service with:
  - Task definition with configurable CPU/memory
  - Application Load Balancer integration
  - Auto-scaling policies
  - CloudWatch logging
  
  Best suited for containerized web applications.

# ❌ Bad: Vague
description: Creates an ECS service
```

#### Tags
```yaml
# ✅ Good: Specific, searchable
tags:
  - ecs
  - fargate
  - container
  - aws
  - load-balancer

# ❌ Bad: Too generic or missing
tags:
  - aws
  - infrastructure
```

### Parameters

#### Required vs Optional

Only mark parameters as truly required:

```yaml
parameters:
  - title: Required Information
    required:
      - service_name      # Always needed
      - environment       # Always needed
    properties:
      service_name:
        title: Service Name
        type: string
      environment:
        title: Environment
        type: string
        enum: [dev, staging, prod]
      
  - title: Optional Configuration
    properties:
      cpu:
        title: CPU Units
        type: number
        default: 256      # Provide defaults for optional fields
      memory:
        title: Memory (MB)
        type: number
        default: 512
```

#### Input Validation

Use JSON Schema validation to prevent errors:

```yaml
parameters:
  properties:
    # String patterns
    bucket_name:
      title: Bucket Name
      type: string
      pattern: '^[a-z0-9][a-z0-9-]*[a-z0-9]$'
      minLength: 3
      maxLength: 63
      description: Must be lowercase, alphanumeric, and hyphens
    
    # Number ranges
    instance_count:
      title: Instance Count
      type: number
      minimum: 1
      maximum: 10
      default: 2
    
    # Email format
    contact_email:
      title: Contact Email
      type: string
      format: email
```

#### Help Text

Provide clear guidance:

```yaml
parameters:
  properties:
    aws_region:
      title: AWS Region
      type: string
      enum:
        - ca-central-1
        - us-east-1
      default: ca-central-1
      ui:help: "Select the AWS region for deployment. Canada Central recommended for Canadian data residency."
    
    product_name:
      title: Product Name
      type: string
      ui:help: "Format: lowercase-with-hyphens. Example: my-application"
      ui:placeholder: "my-product-name"
```

### Steps

#### Step Organization

Organize steps logically:

```yaml
steps:
  # 1. Fetch and prepare content
  - id: fetch-base
    name: Fetch Template Files
    action: fetch:template
    input:
      url: ./content
      values: ${{ parameters }}
  
  # 2. Validate or transform
  - id: log-config
    name: Log Configuration
    action: debug:log
    input:
      message: "Creating ${{ parameters.service_name }} in ${{ parameters.environment }}"
  
  # 3. Publish or create resources
  - id: publish-pr
    name: Create Pull Request
    action: publish:github:pull-request
    input:
      repoUrl: ${{ parameters.repoUrl }}
      branchName: add-${{ parameters.service_name }}
      title: 'Add ${{ parameters.service_name }} configuration'
  
  # 4. Output and next steps
  - id: log-success
    name: Log Success
    action: debug:log
    input:
      message: "Template completed. Review PR: ${{ steps['publish-pr'].output.remoteUrl }}"
```

#### Error Handling

Be explicit about requirements and failures:

```yaml
steps:
  - id: validate-repo
    name: Validate Repository Exists
    action: debug:log
    input:
      message: |
        Checking repository: ${{ parameters.target_repo }}
        Ensure you have write access to this repository.
  
  - id: create-pr
    name: Create Pull Request
    action: publish:github:pull-request
    input:
      repoUrl: ${{ parameters.target_repo }}
      # ... other config
```

### Output

Provide useful links and next steps:

```yaml
output:
  links:
    # Direct links to created resources
    - title: View Pull Request
      url: ${{ steps['publish-pr'].output.remoteUrl }}
      icon: github
    
    # Documentation or next steps
    - title: Deployment Guide
      url: https://docs.example.com/deployment
      icon: docs
    
    # Related resources
    - title: Monitor in Backstage
      url: /catalog/default/component/${{ parameters.service_name }}
      icon: catalog
  
  text:
    # Summary information
    - title: Next Steps
      content: |
        1. Review and approve the pull request
        2. Merge to trigger CI/CD pipeline
        3. Monitor deployment in AWS Console
        4. Verify service health in monitoring dashboard
```

## Content Files Best Practices

### Jinja2 Templating

#### Whitespace Control

Remove extra blank lines:

```jinja2
{%- set service_name = values.service_name | lower | replace('_', '-') -%}
{%- set resource_name = service_name | replace('-', '_') -%}

resource "aws_instance" "{{ resource_name }}" {
  # No blank lines above from Jinja2 statements
  tags = {
    Name = "{{ service_name }}"
  }
}
```

#### Variable Transformation

Transform inputs into the format you need:

```jinja2
{%- set inputs -%}
# Original input
project_name: "My Project Name"

# Transformations
{%- set project_lower = values.project_name | lower -%}           # my project name
{%- set project_kebab = project_lower | replace(' ', '-') -%}     # my-project-name
{%- set project_snake = project_lower | replace(' ', '_') -%}     # my_project_name
{%- set project_pascal = values.project_name | replace(' ', '') -%} # MyProjectName
{%- endset -%}

# Usage
resource "aws_s3_bucket" "{{ project_snake }}" {
  bucket = "{{ project_kebab }}-bucket"
}
```

#### Conditional Content

Use conditions effectively:

```jinja2
# Terraform example
resource "aws_instance" "main" {
  instance_type = "t3.micro"
  
  {% if values.enable_monitoring -%}
  monitoring = true
  {% endif -%}
  
  tags = {
    Name        = "{{ values.name }}"
    Environment = "{{ values.environment }}"
    {% if values.cost_center -%}
    CostCenter  = "{{ values.cost_center }}"
    {% endif -%}
  }
}
```

#### Loops

Generate repeated configurations:

```jinja2
# Create resources for multiple environments
{% for env in ['dev', 'staging', 'prod'] -%}
resource "aws_s3_bucket" "{{ values.name }}_{{ env }}" {
  bucket = "{{ values.name }}-{{ env }}"
  
  tags = {
    Environment = "{{ env }}"
  }
}

{% endfor -%}
```

### File Organization

Structure your content directory logically:

```
content/
├── README.md                 # Documentation
├── .github/
│   └── workflows/
│       └── ci.yml           # CI/CD workflows
├── terraform/
│   ├── main.tf              # Main infrastructure
│   ├── variables.tf         # Variable definitions
│   ├── outputs.tf           # Output values
│   └── modules/             # Local modules
└── docs/
    └── index.md             # Additional documentation
```

## Security Best Practices

### Sensitive Data

❌ **Never** hardcode sensitive data:

```yaml
# BAD - Don't do this
content/config.yaml:
  database:
    password: "hardcoded_password"  # NEVER
```

✅ **Use** placeholders and secret management:

```yaml
# GOOD
content/config.yaml:
  database:
    password: ${{ secrets.DB_PASSWORD }}  # Reference from secret manager
```

### Least Privilege

Create IAM policies with minimal permissions:

```hcl
# ✅ Good: Specific permissions
resource "aws_iam_policy" "app_policy" {
  name = "${var.app_name}-policy"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.app_bucket.arn}/*"
      }
    ]
  })
}

# ❌ Bad: Overly permissive
resource "aws_iam_policy" "app_policy" {
  policy = jsonencode({
    Statement = [{
      Effect = "Allow"
      Action = "*"
      Resource = "*"
    }]
  })
}
```

### Input Sanitization

Validate and sanitize all inputs:

```yaml
parameters:
  properties:
    resource_name:
      title: Resource Name
      type: string
      pattern: '^[a-zA-Z0-9-]+$'  # Prevent injection
      maxLength: 64
      description: Alphanumeric and hyphens only
```

## Testing Best Practices

### Pre-Commit Validation

Test templates before committing:

```bash
# Validate YAML syntax
yamllint template.yaml

# Test template generation locally
npx @backstage/plugin-scaffolder-backend-module-file-system-scaffold-template \
  --template-path ./template.yaml

# Generate docs
npx techdocs-cli generate --no-docker
```

### Integration Testing

After deploying a template:

1. Test with minimal required parameters
2. Test with all parameters filled
3. Test edge cases (max lengths, special characters)
4. Verify all steps execute successfully
5. Check generated code quality
6. Confirm resources are created correctly

### Documentation Testing

Ensure documentation is clear:

1. Have someone unfamiliar with the template try to use it
2. Check that error messages are helpful
3. Verify links work
4. Ensure examples are accurate

## Maintenance Best Practices

### Versioning

Consider versioning for breaking changes:

```yaml
metadata:
  name: ecs-service-v2  # Version in name
  title: Create ECS Service (v2)
  description: |
    Updated version with new features.
    See v1 for legacy template.
```

### Deprecation

When deprecating a template:

```yaml
metadata:
  name: old-template
  title: "[DEPRECATED] Old Template"
  description: |
    ⚠️ This template is deprecated. Please use 'new-template' instead.
    
    Migration guide: https://docs.example.com/migration
  tags:
    - deprecated
```

### Documentation Updates

Keep documentation current:

- Update when parameters change
- Document new features
- Add troubleshooting tips
- Include migration guides

### Regular Reviews

Schedule regular template reviews:

- Check for outdated dependencies
- Update to new best practices
- Verify links still work
- Test with current Backstage version

## Performance Best Practices

### Minimize Steps

Combine related actions:

```yaml
# ✅ Good: Combined in one step
- id: publish
  name: Publish to GitHub
  action: publish:github:pull-request
  input:
    repoUrl: ${{ parameters.repoUrl }}
    branchName: add-feature
    title: 'Add feature'

# ❌ Bad: Unnecessary separate steps
- id: create-branch
  name: Create Branch
  # ... 
- id: add-files
  name: Add Files
  # ...
- id: create-pr
  name: Create PR
  # ...
```

### Optimize Content

Keep content files focused:

```
# ✅ Good: Focused template files
content/
├── infrastructure/
│   ├── vpc.tf
│   ├── ecs.tf
│   └── rds.tf

# ❌ Bad: Everything in one giant file
content/
└── everything.tf (2000 lines)
```

## Accessibility Best Practices

### Clear Labels

Use descriptive, accessible labels:

```yaml
parameters:
  properties:
    instance_type:
      title: EC2 Instance Type  # Clear, specific
      description: The type of EC2 instance to launch
      # Not just: "Type"
```

### Help Text

Provide context for complex options:

```yaml
parameters:
  properties:
    subnet_configuration:
      title: Subnet Configuration
      type: string
      enum:
        - public-only
        - private-only
        - mixed
      ui:help: |
        • public-only: Resources accessible from internet
        • private-only: Internal resources only
        • mixed: Both public and private subnets
```

## Common Pitfalls to Avoid

### 1. Over-Engineering

❌ Don't create overly complex templates
✅ Keep templates focused and composable

### 2. Insufficient Validation

❌ Accepting any input without validation
✅ Use JSON Schema validation

### 3. Poor Error Messages

❌ Generic error messages
✅ Specific, actionable error messages

### 4. Hardcoding Values

❌ Hardcoding region, account IDs, etc.
✅ Use parameters and environment variables

### 5. Ignoring Existing Standards

❌ Creating your own conventions
✅ Follow organization and community standards

### 6. Missing Documentation

❌ No README or usage examples
✅ Comprehensive documentation

### 7. Forgetting Edge Cases

❌ Only testing happy path
✅ Test edge cases and error scenarios

## Checklist for New Templates

Before submitting a new template, verify:

- [ ] Template metadata is complete and accurate
- [ ] All parameters have descriptions and help text
- [ ] Required parameters are truly necessary
- [ ] Input validation is comprehensive
- [ ] Steps are organized logically
- [ ] Error handling is in place
- [ ] Output provides useful links and information
- [ ] Content files use proper Jinja2 syntax
- [ ] No sensitive data is hardcoded
- [ ] Template follows naming conventions
- [ ] Documentation is included
- [ ] Template has been tested end-to-end
- [ ] Edge cases have been considered
- [ ] Template follows security best practices
- [ ] Code is well-commented

## Resources

- [Backstage Software Templates Documentation](https://backstage.io/docs/features/software-templates/)
- [JSON Schema Validation](https://json-schema.org/)
- [Jinja2 Template Documentation](https://jinja.palletsprojects.com/)
- [Templates Overview](templates-overview.md)
- [Creating Templates Guide](creating-templates.md)
