include {
  path = find_in_parent_folders()  # This will include the root terragrunt.hcl file
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git"
}

# Remote state configuration for Dev environment
inputs = {
  bucket        = "your-remote-state-bucket-name"
  versioning    = {
    enabled = true
  }
  tags = {
    Name        = "terraform-remote-state"
    Environment = "dev"
  }
}
