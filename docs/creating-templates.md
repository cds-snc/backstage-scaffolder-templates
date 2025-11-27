# Creating Your Own Templates

This guide walks you through creating custom Backstage scaffolder templates for your organization.

## Prerequisites

Before creating a template, you should have:

- Basic understanding of [Backstage Software Templates](https://backstage.io/docs/features/software-templates/)
- Familiarity with YAML syntax
- Knowledge of the technology stack your template will use (Terraform, Node.js, etc.)
- Access to this repository

## Template Structure

Every Backstage template consists of two main parts:

### 1. Template Definition (`template.yaml`)

The template definition file describes:
- Metadata (name, description, tags)
- Input parameters (form fields)
- Steps to execute
- Output information

### 2. Content Directory (`content/`)

The content directory contains:
- Files to be templated
- Configuration files
- Code scaffolding
- Any static assets

## Basic Template Anatomy

```yaml
apiVersion: scaffolder.backstage.io/v1beta3
kind: Template
metadata:
  name: my-template-name
  title: My Template Title
  description: |
    A clear description of what this template creates
  tags:
    - terraform
    - aws
spec:
  owner: group:cds-snc/internal-sre
  type: service
  
  parameters:
    - title: Configuration
      required:
        - project_name
      properties:
        project_name:
          title: Project Name
          type: string
          description: Name of your project
  
  steps:
    - id: fetch-base
      name: Fetch Base
      action: fetch:template
      input:
        url: ./content
        values:
          project_name: ${{ parameters.project_name }}
    
    - id: publish
      name: Publish to GitHub
      action: publish:github
      input:
        repoUrl: github.com?repo=${{ parameters.project_name }}&owner=cds-snc
  
  output:
    links:
      - title: Repository
        url: ${{ steps.publish.output.remoteUrl }}
```

## Step-by-Step Guide

### Step 1: Create Template Directory

```bash
cd templates/
mkdir my-new-template
cd my-new-template
```

### Step 2: Create template.yaml

Start with the metadata section:

```yaml
apiVersion: scaffolder.backstage.io/v1beta3
kind: Template
metadata:
  name: my-new-template
  title: My New Template
  description: |
    Brief description of what this template creates.
    You can use multiple lines.
  tags:
    - relevant-tag
    - technology-stack
spec:
  owner: group:cds-snc/internal-sre
  type: service
```

### Step 3: Define Input Parameters

Parameters create the form that users fill out:

```yaml
parameters:
  - title: Basic Information
    required:
      - name
      - description
    properties:
      name:
        title: Name
        type: string
        description: The name of your resource
        ui:autofocus: true
      description:
        title: Description
        type: string
        description: A brief description
      
  - title: Configuration Options
    properties:
      environment:
        title: Environment
        type: string
        enum:
          - development
          - staging
          - production
        default: development
      enable_monitoring:
        title: Enable Monitoring
        type: boolean
        default: true
```

#### Parameter Types

**String**:
```yaml
project_name:
  title: Project Name
  type: string
  pattern: '^[a-z0-9-]+$'
```

**Number**:
```yaml
instance_count:
  title: Instance Count
  type: number
  minimum: 1
  maximum: 10
```

**Boolean**:
```yaml
enable_feature:
  title: Enable Feature
  type: boolean
  default: false
```

**Enum (Dropdown)**:
```yaml
region:
  title: AWS Region
  type: string
  enum:
    - us-east-1
    - ca-central-1
  enumNames:
    - US East
    - Canada Central
```

**Array**:
```yaml
tags:
  title: Tags
  type: array
  items:
    type: string
```

### Step 4: Define Steps

Steps are actions that execute when the template runs:

#### Fetch Template Content

```yaml
steps:
  - id: fetch-base
    name: Fetch Base
    action: fetch:template
    input:
      url: ./content
      values:
        name: ${{ parameters.name }}
        description: ${{ parameters.description }}
```

#### Create a Pull Request

```yaml
  - id: create-pr
    name: Create Pull Request
    action: publish:github:pull-request
    input:
      repoUrl: github.com?repo=my-repo&owner=cds-snc
      branchName: feature/${{ parameters.name }}
      title: 'Add ${{ parameters.name }}'
      description: |
        This PR adds ${{ parameters.name }}
        
        Created by Backstage template
```

#### Create a New Repository

```yaml
  - id: publish
    name: Publish Repository
    action: publish:github
    input:
      repoUrl: github.com?repo=${{ parameters.name }}&owner=cds-snc
      description: ${{ parameters.description }}
      defaultBranch: main
```

#### Log Messages

```yaml
  - id: log-message
    name: Log Message
    action: debug:log
    input:
      message: |
        Template completed successfully!
        Project: ${{ parameters.name }}
```

### Step 5: Create Content Directory

Create a `content/` directory with your template files:

```bash
mkdir content
cd content
```

#### Using Jinja2 Templates

Files in `content/` can use Jinja2 templating:

**Example: `content/README.md`**
```markdown
# {{ values.name }}

{{ values.description }}

## Getting Started

This project was created using Backstage.

Environment: {{ values.environment }}
{% if values.enable_monitoring %}
Monitoring is enabled.
{% endif %}
```

**Example: `content/terraform/main.tf`**
```hcl
{%- set resource_name = values.name | replace('-', '_') -%}

resource "aws_s3_bucket" "{{ resource_name }}" {
  bucket = "{{ values.name }}-bucket"
  
  tags = {
    Name        = "{{ values.name }}"
    Environment = "{{ values.environment }}"
  }
}
```

#### Jinja2 Filters

Common filters you can use:

- `{{ value | lower }}` - Convert to lowercase
- `{{ value | upper }}` - Convert to uppercase
- `{{ value | title }}` - Convert to title case
- `{{ value | replace('-', '_') }}` - Replace characters
- `{{ value | dump }}` - JSON serialize (use sparingly)

### Step 6: Define Output

Show users what was created:

```yaml
output:
  links:
    - title: Repository
      url: ${{ steps.publish.output.remoteUrl }}
      icon: github
    - title: View Pull Request
      url: ${{ steps.create-pr.output.remoteUrl }}
      icon: github
```

## Testing Your Template

### Local Testing

1. Generate documentation locally:
```bash
npx techdocs-cli generate --no-docker
```

2. Test template syntax:
```bash
# Validate YAML
yamllint templates/my-new-template/template.yaml
```

### Testing in Backstage

1. Commit your template to a branch
2. Configure Backstage to read from your branch (if needed)
3. Navigate to "Create" in Backstage
4. Find and test your template
5. Verify all steps execute correctly
6. Check the output matches expectations

## Best Practices

### Template Metadata

✅ **DO**:
- Use clear, descriptive titles
- Write detailed descriptions
- Add relevant tags
- Specify the owner group

❌ **DON'T**:
- Use vague names like "template1"
- Skip the description
- Forget to add tags

### Parameters

✅ **DO**:
- Validate inputs with patterns
- Provide helpful descriptions
- Use sensible defaults
- Group related parameters

❌ **DON'T**:
- Ask for too many parameters
- Use unclear field names
- Skip validation
- Make everything required

### Content Files

✅ **DO**:
- Use Jinja2 filters to transform values
- Remove whitespace with `{%- -%}`
- Test generated files
- Include helpful comments

❌ **DON'T**:
- Hardcode values that should be parameterized
- Leave blank lines from Jinja2 statements
- Use overly complex logic
- Include sensitive information

### Steps

✅ **DO**:
- Log meaningful messages
- Handle errors gracefully
- Use descriptive step names
- Provide clear output

❌ **DON'T**:
- Chain too many steps
- Skip error handling
- Use cryptic step IDs
- Forget to show results

## Common Patterns

### Multi-Environment Template

```yaml
parameters:
  - title: Environment Configuration
    properties:
      environments:
        title: Environments
        type: array
        items:
          type: string
          enum:
            - development
            - staging
            - production
        default: ["development"]
```

### Conditional File Generation

```yaml
# In template.yaml
parameters:
  properties:
    include_tests:
      title: Include Tests
      type: boolean
      default: true
```

```jinja2
{# In content file #}
{% if values.include_tests %}
# Test files would be generated here
{% endif %}
```

### Dynamic Resource Naming

```yaml
# In content/terraform/main.tf
{%- set safe_name = values.project_name | lower | replace(' ', '-') -%}
{%- set resource_name = safe_name | replace('-', '_') -%}

resource "aws_instance" "{{ resource_name }}" {
  tags = {
    Name = "{{ safe_name }}"
  }
}
```

## Troubleshooting

### Template Not Showing in Backstage

- Verify `template.yaml` syntax is correct
- Check that the template is in the correct directory
- Ensure Backstage is configured to read from your repository
- Refresh the Backstage catalog

### Parameters Not Working

- Check required fields are specified
- Verify parameter types match expected values
- Test with different input values
- Review parameter validation rules

### Content Files Not Generated

- Check Jinja2 syntax is correct
- Verify `fetch:template` action is configured properly
- Look for whitespace issues from `{% %}` statements
- Test locally with techdocs-cli

### Step Execution Failures

- Review GitHub token permissions
- Check repository access rights
- Verify action names are correct
- Look at Backstage backend logs

## Next Steps

- Review [Templates Overview](templates-overview.md) for examples
- Read [Template Best Practices](best-practices.md)
- Check [Backstage Template Documentation](https://backstage.io/docs/features/software-templates/)
- Contribute your template back to the repository!
