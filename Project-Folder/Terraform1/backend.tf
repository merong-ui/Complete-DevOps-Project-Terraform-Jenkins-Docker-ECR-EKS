terraform {
  backend "s3" {
    bucket         = "<terraform-state-bucket>"      # The name of the pre-existing S3 bucket
    key            = "devops/terraform.tfstate"      # The file path inside the bucket where the state file will live
    region         = "us-east-1"                     # The AWS region where the bucket resides
    use_lockfile   = true                            # Enables state locking to prevent concurrent modifications
  }
}
