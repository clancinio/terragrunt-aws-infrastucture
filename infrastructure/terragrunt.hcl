# Root configuration for all environments
terraform {
  # No source here, each environment will define its own module source
}

# Define AWS provider dynamically for each environment
generate "provider" {
  path      = "${get_terragrunt_dir()}/provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "eu-west-1"
}
EOF
}

# Root configuration for all environments
remote_state {
  backend = "s3"

  config = {
    bucket  = "my-terraform-state-bucket"                # Replace with your S3 bucket name
    key     = "${path_relative_to_include()}/terraform.tfstate"  # State file path based on folder structure
    region  = "eu-west-1"                                # AWS region where your S3 bucket is located
    encrypt = true                                       # Encrypt the state for security
  }
}
