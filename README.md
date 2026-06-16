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

## 📸 Proof of Work & Verification Placeholders

1. Infrastructure Provisioning (Terraform Output)
   
   <img width="566" height="534" alt="Screenshot 2026-06-16 155740" src="https://github.com/user-attachments/assets/6e751d5d-84cd-4010-9a95-ed6c3654153f" />


3. GitHub Webhook Communication
   <img width="931" height="377" alt="image" src="https://github.com/user-attachments/assets/c39dbfa9-9bd9-47a7-9095-cfda472027a8" />

4. Jenkins Multi-Stage Build View

   
5. Private Amazon ECR Repository
   <img width="1696" height="192" alt="Screenshot 2026-06-16 170457" src="https://github.com/user-attachments/assets/0a81e0d9-d484-4534-a7b5-0cabb4418e6f" />

6. Amazon EKS Active Resource Status
   <img width="539" height="85" alt="Screenshot 2026-06-16 170204" src="https://github.com/user-attachments/assets/93dbe539-8e15-4c3b-bd25-d9bd5e9b1da4" />

