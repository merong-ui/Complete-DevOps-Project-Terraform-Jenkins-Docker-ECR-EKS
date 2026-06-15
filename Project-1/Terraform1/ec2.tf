// to use a valid Amazon Linux
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}


# Create an EC2 instance for Jenkins
resource "aws_instance" "jenkins" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.medium"
  
  # Configure the root block device with a larger volume size and use gp3 for better performance
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }


  key_name = "devops-new-key"

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.sg.id]

  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

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