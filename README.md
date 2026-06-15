# 🚀 DevOps CI/CD Pipeline Project (Terraform + Jenkins + EKS)

## 📌 Overview

This project demonstrates a complete DevOps CI/CD pipeline using:

- Terraform (Infrastructure as Code)
- AWS (EC2, EKS, ECR, VPC, IAM)
- Jenkins (CI/CD automation)
- Docker (Containerization)
- Kubernetes (EKS deployment)
- SonarQube (Code quality scanning)
- GitHub Webhooks (Automation trigger)

---

## 🏗️ Architecture

Developer → GitHub → Jenkins (EC2 Docker) → ECR → EKS

---

## ⚙️ Infrastructure (Terraform)

Terraform provisions:

- VPC (10.0.0.0/16)
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- EC2 Jenkins Server
- IAM Roles
- ECR Repository
- EKS Cluster

<img width="959" height="143" alt="image" src="https://github.com/user-attachments/assets/4388b24a-a1d6-4138-941f-2afff35c48d5" />

<img width="1747" height="208" alt="image" src="https://github.com/user-attachments/assets/79533790-dcba-4421-9b22-2ac84365ed46" />

<img width="1873" height="244" alt="image" src="https://github.com/user-attachments/assets/68d3f335-c100-464d-b133-d25a9baec15e" />

<img width="1785" height="197" alt="image" src="https://github.com/user-attachments/assets/9604cbcf-c369-4e75-bdc8-450659aed1e8" />




---

## 🚀 CI/CD Pipeline Flow

1. Code pushed to GitHub
2. GitHub triggers Jenkins webhook
3. Jenkins pulls code
4. Runs Unit Tests
5. Runs SonarQube scan
6. Builds Docker image
7. Pushes image to ECR
8. Deploys to EKS
9. Verifies rollout

---

## 🐳 Docker

Dockerfile builds Python Flask app:

- Base image: python:3.11-slim
- Exposes port 5000
- Runs Flask application

---

## ☸️ Kubernetes

Deployment:
- 2 replicas
- Rolling updates
- Auto-healing

Service:
- LoadBalancer type
- Exposes app externally

---

## 🔐 Security

- IAM Roles (no hardcoded AWS keys)
- Jenkins credentials store
- Private subnet for worker nodes
- Security Groups control access

---

## 📦 How to Deploy

### 1. Terraform

```bash
terraform init
terraform apply
