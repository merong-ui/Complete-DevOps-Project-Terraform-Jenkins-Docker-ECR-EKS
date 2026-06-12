# End-to-End DevOps Project: Terraform + Jenkins + Docker + ECR + EKS

## Overview

This project demonstrates a complete DevOps platform built on AWS using Infrastructure as Code, CI/CD automation, containerization, and Kubernetes.

The infrastructure is provisioned using Terraform, while Jenkins automates application testing, image creation, and deployment to Amazon EKS.

---

## Architecture

Developer → GitHub → Jenkins (Docker on EC2) → Amazon ECR → Amazon EKS

---

## Technologies Used

### Infrastructure as Code
- Terraform

### Cloud Provider
- AWS

### Compute
- Amazon EC2

### Containerization
- Docker

### Container Registry
- Amazon ECR

### Kubernetes
- Amazon EKS

### CI/CD
- Jenkins

### Source Control
- GitHub

### Code Quality
- SonarQube

---

## Infrastructure Provisioned by Terraform

- VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles
- ECR Repository
- Jenkins EC2 Instance
- EKS Cluster
- Managed Node Group

---

## CI/CD Workflow

1. Developer pushes code to GitHub.
2. GitHub Webhook triggers Jenkins.
3. Jenkins checks out source code.
4. Unit tests run inside Docker containers.
5. SonarQube performs static code analysis.
6. Docker image is built.
7. Image is pushed to Amazon ECR.
8. Jenkins updates Kubernetes deployment.
9. Amazon EKS performs rolling deployment.

---

## Terraform Deployment

### Initialize Terraform

```bash
terraform init
```

### Review Changes

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

---

## Jenkins Access

```text
http://<EC2-PUBLIC-IP>:8080
```

Retrieve initial password:

```bash
docker logs jenkins
```

---

## Kubernetes Deployment

```bash
kubectl apply -f k8s/
```

---

## Security Best Practices

- IAM Roles instead of Access Keys
- Remote Terraform State in S3
- DynamoDB State Locking
- Jenkins Credentials Store
- SonarQube Quality Gates
- Kubernetes Rolling Updates

---

