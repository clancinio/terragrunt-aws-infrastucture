# infrastructure/environments/dev/remote_state/terragrunt.hcl

# Include the root Terragrunt configuration
include {
  path = find_in_parent_folders()  # This will include the root terragrunt.hcl file
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git"
}

# Load variables from YAML file or define them here
locals {
  remote_state_bucket = "remote-state-bucket"  # Specify your remote state S3 bucket name
}

inputs = {
  bucket = local.remote_state_bucket
  versioning = {
    enabled = true  # Enable versioning if needed
  }
  tags = {
    Environment = "dev"
  }
}

# Define the backend for the remote state
terraform {
  backend "s3" {
    bucket         = local.remote_state_bucket
    key            = "dev/terraform.tfstate"      # Unique key for the environment
    region         = "eu-west-1"                   # Your AWS region
    encrypt        = true
  }
}
