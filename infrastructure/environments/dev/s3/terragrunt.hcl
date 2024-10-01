# Include the root Terragrunt configuration
include {
  path = find_in_parent_folders()  # This will search upwards for the root terragrunt.hcl file
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git"
  backend "s3" {}
}

# Load variables from YAML file
locals {
  vars = yamldecode(file("${get_terragrunt_dir()}/variables.yaml"))
}

# Remote state configuration
remote_state {
  backend = "s3"
  config = {
    bucket         = "my-terraform-state-bucket"                 # The name of your S3 bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"  # Path to the state file
    region         = "eu-west-1"                                  # The region where your S3 bucket is located
    encrypt        = true                                           # Encrypt the state file
  }
}

# Pass inputs from YAML file to Terraform module
inputs = {
  bucket     = local.vars.bucket_name
  versioning = {
    enabled = local.vars.versioning.enabled
  }
  tags       = local.vars.tags
}
