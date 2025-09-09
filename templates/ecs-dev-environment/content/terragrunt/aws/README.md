### AWS Service Directories

The directory structure for AWS services organizes Terraform configurations by service:

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

Each directory corresponds to an AWS service and contains the following Terraform files:

- **`input.tf`**: Defines the input variables used to parameterize the Terraform configurations.
- **`main.tf`**: Contains the core Terraform code that defines the resources to be created in AWS.
- **`output.tf`**: Defines the output variables that Terraform will return after applying the configuration.
