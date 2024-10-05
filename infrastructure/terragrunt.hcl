# Root configuration for all environments
generate "terraform" {
  path      = "${get_terragrunt_dir()}/terraform.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket         = "remote-state-bucket"           # Ensure this matches the bucket you created
    key            = "\${path_relative_to_include()}/terraform.tfstate"  # Unique key for each environment
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "your-dynamodb-lock-table"  # Optional for state locking
  }
}

provider "aws" {
  region = "eu-west-1"
}
EOF
}

# Remote state configuration (applies to all environments)
remote_state {
  backend = "s3"
  config  = {
    bucket         = "remote-state-bucket"           # Ensure this matches the bucket you created
    key            = "${path_relative_to_include()}/terraform.tfstate"  # Unique key for each environment
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "your-dynamodb-lock-table"  # Optional for state locking
  }
}