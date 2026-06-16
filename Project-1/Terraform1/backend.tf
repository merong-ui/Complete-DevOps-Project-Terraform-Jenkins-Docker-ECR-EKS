terraform {
  backend "s3" {
    bucket         = "for-jenkins-s3-terraform-state2"
    key            = "devops/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
  }
}