#!/bin/bash

# Update system packages
apt update -y

# Install Docker
apt install docker.io -y

# Start Docker service
systemctl start docker
systemctl enable docker

# Create Jenkins volume (persistent storage)
docker volume create jenkins_home

# Run Jenkins container
docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name jenkins \
  --restart unless-stopped \
  jenkins/jenkins:lts