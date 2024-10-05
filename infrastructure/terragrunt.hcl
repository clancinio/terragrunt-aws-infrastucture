# Root configuration for all environments
terraform {
  backend "s3" {}
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
  config  = {
    bucket         = "remote-state-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "your-dynamodb-lock-table"  # Optional, for state locking
  }
}
