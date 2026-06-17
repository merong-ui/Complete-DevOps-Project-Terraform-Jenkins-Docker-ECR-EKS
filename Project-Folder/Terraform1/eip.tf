# Create an Elastic IP (EIP) for Jenkins
# This EIP will be associated with the Jenkins EC2 instance to provide a static public IP address.
resource "aws_eip" "jenkins_eip" {
  domain = "vpc"

  tags = {
    Name = "jenkins-eip"
  }
}