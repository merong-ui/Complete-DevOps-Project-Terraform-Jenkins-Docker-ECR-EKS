## End-to-End Enterprise CI/CD DevOps Pipeline Project (Terraform, Jenkins, Docker, ECR, & EKS)


This repository contains a fully automated GitOps CI/CD pipeline leveraging **Jenkins**, **Docker**, **Amazon ECR**, and **Amazon EKS (Kubernetes)**. The underlying cloud infrastructure is dynamically orchestrated using **Terraform** as Infrastructure as Code (IaC).

---
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

<img width="1011" height="550" alt="Screenshot 2026-06-16 205712" src="https://github.com/user-attachments/assets/81856ded-dc99-46fe-8291-aadf382338dd" />

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
   
   - EC2 Jenkins Server and worker reservers:
     
     <img width="1866" height="287" alt="Screenshot 2026-06-16 213510" src="https://github.com/user-attachments/assets/8cb79256-4bb7-4630-8273-5fe51769bdac" />

   - Amazon EKS Active Resource Cluster Map:

    <img width="1534" height="311" alt="image" src="https://github.com/user-attachments/assets/c21ec1c9-3438-4b39-8336-a54fd78e2cff" />

    - Amazon EKS Active Resource Status:
   
    <img width="539" height="85" alt="Screenshot 2026-06-16 170204" src="https://github.com/user-attachments/assets/93dbe539-8e15-4c3b-bd25-d9bd5e9b1da4" />
    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
2. Private Container Registry Storage (Amazon ECR)
   
     <img width="1696" height="192" alt="Screenshot 2026-06-16 170457" src="https://github.com/user-attachments/assets/0a81e0d9-d484-4534-a7b5-0cabb4418e6f" />
     
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   
4. GitHub Webhook Communication
   
     <img width="531" height="177" alt="image" src="https://github.com/user-attachments/assets/c39dbfa9-9bd9-47a7-9095-cfda472027a8" />

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

5. Pipeline Automation Execution (Jenkins Visualization)

   - Interactive Dashboard Stage View Matrix:
   
     <img width="1833" height="482" alt="Screenshot 2026-06-16 204710" src="https://github.com/user-attachments/assets/e1067606-d667-4103-b120-1fa91eab86ce" />

   - Pipeline overview:-
     
     <img width="1997" height="623" alt="image" src="https://github.com/user-attachments/assets/79ae11ab-3db7-4c96-845c-fbc378d5b6b9" />

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  6. Kubernetes Live Running Status:-
   
  - Cluster Nodes Connectivity Handshake & Application Rollout Verification Output:

    <img width="539" height="85" alt="Screenshot 2026-06-16 170204" src="https://github.com/user-attachments/assets/8ad3cf64-2c73-4371-9202-e532ffe2053d" />

    <img width="796" height="138" alt="Screenshot 2026-06-16 213101" src="https://github.com/user-attachments/assets/4ced6cb0-6f66-41ac-b77e-f8aae6d9efb8" />

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   
   
     
 
