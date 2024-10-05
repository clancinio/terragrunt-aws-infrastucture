# infrastructure/environments/dev/remote_state/terragrunt.hcl

# Include the root Terragrunt configuration
include {
  path = find_in_parent_folders()  # This will include the root terragrunt.hcl file
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git"
}

inputs = {
  bucket = "remote-state-bucket"
  versioning = {
    enabled = true  # Enable versioning if needed
  }
  tags = {
    Environment = "dev"
  }
}

