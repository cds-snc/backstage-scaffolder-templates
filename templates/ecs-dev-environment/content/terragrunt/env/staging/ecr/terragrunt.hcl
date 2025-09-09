terraform {
  source = "../../aws/ecr"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  # ECR specific configurations can be added here if needed
}
