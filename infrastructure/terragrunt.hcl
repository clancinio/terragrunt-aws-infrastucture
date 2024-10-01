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

# Remote state configuration (applies to all environments)
remote_state {
  backend = "s3"
  config = {
    bucket         = "your-remote-state-bucket-name"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "your-dynamodb-table-for-locking"
  }
}

# Generate an empty backend block to satisfy Terraform
generate "backend" {
  path      = "${get_terragrunt_dir()}/backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {}
}
EOF
}
