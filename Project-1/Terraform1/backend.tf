terraform {
  backend "s3" {
    bucket         = "company-terraform-state"
    key            = "devops/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
  }
}