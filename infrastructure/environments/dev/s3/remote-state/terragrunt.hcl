include {
  path = find_in_parent_folders()  # This will include the root terragrunt.hcl file
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git"
}

# Remote state configuration for the Dev environment
terraform {
  backend "s3" {
    bucket         = local.remote_state_bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"  # Unique key for the environment
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "your-dynamodb-lock-table"  # Optional for state locking
  }
}
