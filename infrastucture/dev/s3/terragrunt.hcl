# Reference the S3 module from the Terraform AWS modules repository
terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git"
}

# Load variables from the YAML file
locals {
  vars = yamldecode(file("${get_terragrunt_dir()}/variables.yaml"))
}

# Pass the inputs from the YAML file into the module
inputs = {
  bucket     = local.vars.bucket_name
  acl        = local.vars.acl
  versioning = {
    enabled = local.vars.versioning.enabled
  }
  tags       = local.vars.tags
}
