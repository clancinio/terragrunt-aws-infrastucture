# Include the root Terragrunt configuration
include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git"
  # Adding an empty backend block is necessary
  backend "s3" {}
}

# Load variables from YAML file
locals {
  vars = yamldecode(file("${get_terragrunt_dir()}/variables.yaml"))
}

# Pass inputs from YAML file to Terraform module
inputs = {
  bucket     = local.vars.bucket_name
  versioning = {
    enabled = local.vars.versioning.enabled
  }
  tags = local.vars.tags
}
