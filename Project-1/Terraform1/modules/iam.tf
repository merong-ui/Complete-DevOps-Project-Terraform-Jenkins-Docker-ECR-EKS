# Create an IAM role for Jenkins to allow EC2 instances to assume it
# This role will be attached to the EC2 instance profile for Jenkins, allowing it to interact with AWS services securely.
resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-role"
  
# The assume role policy allows EC2 instances to assume this role, granting them the permissions defined in the attached policies.
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

#attach the AmazonEC2ContainerRegistryPowerUser policy to the Jenkins role to allow it to interact with ECR repositories
resource "aws_iam_role_policy_attachment" "ecr_access" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

#attach the AmazonEKSClusterPolicy to the Jenkins role to allow it to interact with EKS clusters
resource "aws_iam_role_policy_attachment" "eks_access" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Create an instance profile for Jenkins and associate it with the IAM role
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-instance-profile"
  role = aws_iam_role.jenkins_role.name
}

