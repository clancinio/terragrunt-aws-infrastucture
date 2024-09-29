terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git"
}

# Load variables from YAML file
locals {
  vars = yamldecode(file("${get_terragrunt_dir()}/variables.yaml"))
}

# Generate provider block for AWS
generate "provider" {
  path      = "${get_terragrunt_dir()}/provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.vars.region}"
}
EOF
}

# Pass inputs from YAML file to Terraform module
inputs = {
  bucket     = local.vars.bucket_name
  acl        = local.vars.acl
  versioning = {
    enabled = local.vars.versioning.enabled
  }
  tags       = local.vars.tags
}
