#!/bin/bash
set -xe

#################################################
# Update OS Packages
#################################################

dnf update -y

#################################################
# Install Docker
#################################################

dnf install -y docker

systemctl enable docker
systemctl start docker

#################################################
# Allow EC2 User To Run Docker Commands
#################################################

usermod -aG docker ec2-user

#################################################
# Install Git
#################################################

dnf install -y git

#################################################
# Install unzip
#################################################

dnf install -y unzip

#################################################
# Install AWS CLI v2
#################################################

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

unzip awscliv2.zip

./aws/install

#################################################
# Install kubectl
#################################################

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

mv kubectl /usr/local/bin/

#################################################
# Verify Installations
#################################################

docker --version

git --version

aws --version

kubectl version --client

#################################################
# Create Jenkins Persistent Volume
#################################################

docker volume create jenkins_home

#################################################
# Run Jenkins Container
#################################################

docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --restart unless-stopped \
  jenkins/jenkins:lts-jdk21

#################################################
# Wait For Jenkins Startup
#################################################

sleep 60

#################################################
# Show Initial Admin Password
#################################################

docker logs jenkins > /home/ec2-user/jenkins.log

chown ec2-user:ec2-user /home/ec2-user/jenkins.log