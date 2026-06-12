# s3-backend.tf (bootstrap file)

resource "aws_s3_bucket" "terraform_state" {
  bucket = "for-jenkins-s3-terraform-state"

  tags = {
    Name = "terraform-state"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}