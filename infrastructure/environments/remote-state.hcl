include {
  path = find_in_parent_folders()  # This will include the root terragrunt.hcl file
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git"
}

# Remote state configuration for Dev environment
remote_state {
  backend = "s3"
  config = {
    bucket         = "your-remote-state-bucket"
    key            = "dev/terraform.tfstate"   # Unique key for dev environment
    region         = "eu-west-1"
    encrypt        = true
  }
}
