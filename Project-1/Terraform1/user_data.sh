#!/bin/bash
set -xe

# Update system packages
dnf update -y

# Install Docker on the host EC2 instance
dnf install -y docker
systemctl enable docker
systemctl start docker

# Add the default user to the docker group
usermod -aG docker ec2-user

# Pull the stable Jenkins image ahead of time
docker pull jenkins/jenkins:lts-jdk21

# Launch Jenkins with the Host Docker Daemon Socket mounted
docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -u root \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --restart unless-stopped \
  jenkins/jenkins:lts-jdk21

# Wait a few seconds for Jenkins to initialize baseline directory paths
sleep 10

# Automatically inject the Docker CLI binary directly inside the running Jenkins container
docker exec -u 0 jenkins bash -c "
  apt-get update && apt-get install -y curl
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
"