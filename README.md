# End-to-End Enterprise CI/CD DevOps Pipeline
### Terraform + Jenkins + Docker + Amazon ECR + Amazon EKS

This repository demonstrates a production-inspired DevOps platform that automates infrastructure provisioning, application delivery, and Kubernetes deployments on AWS.

The objective of this project is to showcase how modern DevOps teams build and operate cloud-native applications using Infrastructure as Code (IaC), CI/CD automation, containerization, and Kubernetes orchestration.

Rather than manually provisioning infrastructure or deploying applications through the AWS Management Console, the entire environment is defined as code and deployed through automated pipelines.

The architecture and implementation patterns used in this project closely mirror practices commonly found in enterprise AWS environments, including:

- Infrastructure as Code using Terraform
- Containerized CI/CD workloads using Jenkins and Docker
- Private image management with Amazon ECR
- Kubernetes application deployments on Amazon EKS
- IAM Role-based authentication (no hardcoded credentials)
- Automated rolling deployments with deployment verification
- Public/private subnet network segmentation
- Production-style VPC architecture

---

# Project Objectives

This project demonstrates how to:

- Provision AWS infrastructure using Terraform
- Deploy and manage a Kubernetes cluster using Amazon EKS
- Build and package applications using Docker
- Automate software delivery through Jenkins
- Store versioned container images in Amazon ECR
- Deploy applications to Kubernetes using rolling updates
- Implement AWS security best practices using IAM Roles
- Create a repeatable and scalable deployment workflow

---

# CI/CD Workflow

```text
Developer
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Webhook
    │
    ▼
Jenkins (Docker on EC2)
    │
    ├── Source Checkout
    ├── Unit Testing
    ├── Docker Image Build
    ├── Image Tagging
    ├── Push Image to Amazon ECR
    │
    ▼
Amazon EKS
    │
    ├── Rolling Deployment
    ├── Health Verification
    └── Zero-Downtime Updates
```

---

## 🏗️ Architecture

Developer → GitHub → Jenkins (EC2 Docker) → ECR → EKS

<img width="1011" height="550" alt="Screenshot 2026-06-16 205712" src="https://github.com/user-attachments/assets/81856ded-dc99-46fe-8291-aadf382338dd" />

---

# Technology Stack

| Category | Technology |
|-----------|------------|
| Cloud Platform | AWS |
| Infrastructure as Code | Terraform |
| Source Control | GitHub |
| CI/CD | Jenkins |
| Containerization | Docker |
| Container Registry | Amazon ECR |
| Container Orchestration | Amazon EKS |
| Kubernetes CLI | kubectl |
| Programming Language | Python |
| Operating System | Amazon Linux 2023 |

---

# Infrastructure Provisioning (Terraform)

All AWS resources are provisioned through Terraform.

## Resources Created

- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Elastic IP
- Security Groups
- IAM Roles
- Amazon ECR Repository
- Jenkins EC2 Server
- Amazon EKS Cluster
- EKS Managed Node Groups

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

# Proof of Implementation

## 1. Infrastructure Provisioning 
   
  - Jenkins EC2 Server and worker reservers:
     
  <img width="1866" height="287" alt="Screenshot 2026-06-16 213510" src="https://github.com/user-attachments/assets/8cb79256-4bb7-4630-8273-5fe51769bdac" />


  - Amazon EKS Active Resource Cluster Map:

  <img width="1534" height="311" alt="image" src="https://github.com/user-attachments/assets/c21ec1c9-3438-4b39-8336-a54fd78e2cff" />


    
## 2. Amazon ECR Repository


  <img width="1903" height="568" alt="Screenshot 2026-06-16 210536" src="https://github.com/user-attachments/assets/4a24dffc-7bd6-4e20-a42d-2b5cf43b33a9" />

   
## 3. GitHub Webhook Configuration
   
   <img width="531" height="177" alt="image" src="https://github.com/user-attachments/assets/c39dbfa9-9bd9-47a7-9095-cfda472027a8" />



## 4. Jenkins Pipeline Execution

   - Stage View Matrix:
   
     <img width="1833" height="482" alt="Screenshot 2026-06-16 204710" src="https://github.com/user-attachments/assets/e1067606-d667-4103-b120-1fa91eab86ce" />
     

   - Pipeline Dashboard:-
     
     <img width="1997" height="623" alt="image" src="https://github.com/user-attachments/assets/79ae11ab-3db7-4c96-845c-fbc378d5b6b9" />


  
## 5. Kubernetes Live Running Status:-
   
  - Cluster Nodes Connectivity Handshake & Application Rollout Verification Output:

    <img width="539" height="85" alt="Screenshot 2026-06-16 170204" src="https://github.com/user-attachments/assets/8ad3cf64-2c73-4371-9202-e532ffe2053d" />



    <img width="796" height="138" alt="Screenshot 2026-06-16 213101" src="https://github.com/user-attachments/assets/4ced6cb0-6f66-41ac-b77e-f8aae6d9efb8" />
    
    

# Key Takeaways

This project demonstrates a complete cloud-native software delivery workflow using AWS services and DevOps best practices.

Key areas covered include:

- Infrastructure as Code (Terraform)
- CI/CD Automation (Jenkins)
- Containerization (Docker)
- Container Registry (Amazon ECR)
- Kubernetes Orchestration (Amazon EKS)
- AWS Security Best Practices
- Automated Application Deployment
- Production-Style Network Architecture
   
   
     
 
