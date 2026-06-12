terraform {

  backend "s3" {

    bucket         = "company-terraform-state"
    key            = "devops-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"

  }
}