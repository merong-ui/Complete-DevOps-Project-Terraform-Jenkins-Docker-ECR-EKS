# Create an EC2 instance for Jenkins
resource "aws_instance" "jenkins" {

  ami           = "ami-xxxxxxxx"
  instance_type = "t3.medium"

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  # User data script for initializing the Jenkins server that will install Docker, Jenkins, Dependencies, Configuration.
  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "jenkins-server"
  }
}

# Associate the Elastic IP with the Jenkins EC2 instance
resource "aws_eip_association" "jenkins_eip_assoc" {
  instance_id   = aws_instance.jenkins.id
  allocation_id = aws_eip.jenkins_eip.id
}