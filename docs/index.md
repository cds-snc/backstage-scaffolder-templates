# Backstage Scaffolder Templates

Welcome to the Backstage Scaffolder Templates repository. This repository contains templates used by the Backstage Scaffolder to create standardized projects and components. 

Backstage Software Templates are used to create new software components through Backstage. The backstage instance is poinitng to this repo and reads those templates when creating new components through templating. More information on backstage templates can be found [here](https://backstage.io/docs/features/software-templates/).



## Table of Contents

- [Backstage Scaffolder Templates](#backstage-scaffolder-templates)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Getting Started](#getting-started)
  - [Templates](#templates)
  - [Usage](#usage)
  - [Contributing](#contributing)
  - [License](#license)

## Introduction

Backstage is an open platform for building developer portals. This repository contains various scaffolder templates to help bootstrap new projects and components within the Backstage ecosystem, following best practices and organizational standards.

## Getting Started

To use the templates in this repository, you need to have Backstage set up in your environment. If you haven't set up Backstage yet, follow the [Backstage documentation](https://backstage.io/docs/getting-started) to get started.

## Templates

This repository includes a variety of templates. Each template is designed for a specific purpose, such as creating a new service, frontend application, or library. Below is a sample list of available templates:

- **Service Template**: A template for bootstrapping a new AWS backend service such as an S3 bucket.
- **Application Template**: A template for creating a collection of services such as a simple static website. 
- **Documentation Template**: A template for creating a new documentation project.
- **Bootstrapping Template**: A template for bootstrapping a repo with terragrunt/terraform or github actions.

Each template is located in its own directory under the `templates/` folder.

## Usage

To use a template from this repository in your Backstage instance:

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/cds-snc/backstage-scaffolder-templates.git

2. **Copy Templates to Your Backstage Instance**:
    Copy the desired templates from the `templates/` directory into the scaffolder templates directory of your Backstage instance.

3. **Configure Backstage**:
    Update your Backstage configuration to include the new templates. 

4. **Generate New Components**:
    Use the Backstage Scaffolder to generate new components based on the templates. Navigate to the Scaffolder plugin in your Backstage instance, select the template you want to use, and follow the prompts to generate your new project or component.

## Contributing
We welcome contributions to improve and expand the templates in this repository. To contribute:

1. **Fork the Repository**:
    Fork this repository to your own GitHub account.

2. **Create a Branch**:
    Create a new branch for your changes:
```git checkout -b my-feature-branch```

3. **Make Your Changes**:
    Make the necessary changes to the templates or add new templates.

4. **Submit a Pull Request**:
    Push your changes to your fork and open a pull request against the main repository. Provide a clear description of your changes and any relevant context.

## License
This repository is licensed under the MIT License. Feel free to use and modify the templates according to the terms of the license.

For more information about Backstage and its features, visit the (Backstage official websit)[https://backstage.io/].
