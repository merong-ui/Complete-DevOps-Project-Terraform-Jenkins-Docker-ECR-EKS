#!/bin/bash
set -xe

# Update system
dnf update -y

# Install Java (required for Jenkins)
dnf install -y java-17-amazon-corretto

# Install Docker (Amazon Linux way)
dnf install -y docker

# Start Docker
systemctl enable docker
systemctl start docker

# Add ec2-user to docker group
usermod -aG docker ec2-user

# Jenkins repo
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
dnf install -y jenkins

# Start Jenkins
systemctl enable jenkins
systemctl start jenkins