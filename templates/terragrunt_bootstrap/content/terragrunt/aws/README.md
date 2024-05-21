# In the aws directory, we place the terraform files to create the infrastructure in AWS. General format of the directory structure is as follows:
# Cloud computing service directory such as Cloudfront, S3, ECS, RDS, etc. Inside the directory, we can have the following files:
    # |__ input.tf file to define the input variables
    # |__ main.tf file to define the resources
    # |__ output.tf file to define the output variables