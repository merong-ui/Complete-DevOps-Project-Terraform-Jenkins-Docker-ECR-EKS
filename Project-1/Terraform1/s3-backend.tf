# s3-backend.tf 
# This file sets up the S3 bucket for Terraform state storage and enables versioning to protect against accidental deletions or overwrites of the state file.
resource "aws_s3_bucket" "terraform_state" {
  bucket = "<terraform-state-bucket>"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
