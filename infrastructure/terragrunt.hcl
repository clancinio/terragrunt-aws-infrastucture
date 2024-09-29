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
