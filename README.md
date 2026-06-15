## 🚀 CI/CD Pipeline (Jenkins)

This project implements a fully automated CI/CD pipeline using Jenkins.

### Pipeline Flow

1. Developer pushes code to GitHub
2. Jenkins is triggered via webhook
3. Source code is checked out
4. Unit tests are executed using Python container
5. Docker image is built
6. Image is pushed to Amazon ECR
7. Application is deployed to Amazon EKS
8. Kubernetes performs rolling update

### Tools Used

- Terraform
- Jenkins (CI/CD engine)
- Docker (containerization)
- Amazon ECR (image registry)
- Amazon EKS (Kubernetes cluster)
- AWS CLI (automation)
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
- EKS Cluster
- ECR Repository


- EC2 Jenkins Server and worker reservers:-
<img width="931" height="286" alt="image" src="https://github.com/user-attachments/assets/cb672552-a78b-4766-ac26-94863ae30f66" />

- EKS Cluster screenshot:-
<img width="1434" height="211" alt="image" src="https://github.com/user-attachments/assets/c21ec1c9-3438-4b39-8336-a54fd78e2cff" />

- ECR Repository:-
  <img width="1349" height="183" alt="image" src="https://github.com/user-attachments/assets/1397a797-d6aa-4a1a-902d-2e32f9f8133f" />

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
