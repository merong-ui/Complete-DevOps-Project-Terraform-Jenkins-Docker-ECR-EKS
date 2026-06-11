# Complete CI/CD with Jenkins + Docker + ECR + EKS
1. Find the Jenkins Container

On the Docker host, run:

docker ps
<img width="1406" height="86" alt="Screenshot 2026-06-10 162552" src="https://github.com/user-attachments/assets/80f71bee-71b1-4481-8b3c-d655253c0b2c" />
👉 The container name is: myjenkins

The container name is jenkins

2. Access the Jenkins Container (as Root)

The Jenkins user usually does not have permission to install software.

Switch to root (-u 0):

docker exec -u 0 -it myjenkins bash

Verify:

whoami

Output:

root
3. Install kubectl

Update packages:

apt-get update
apt-get install -y curl unzip

Download latest kubectl:

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

Make executable:

chmod +x kubectl

Move to PATH:

mv kubectl /usr/local/bin/

Verify:

kubectl version --client
4. Install AWS CLI

Download AWS CLI:

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

Extract:

unzip awscliv2.zip

Install:

./aws/install

Verify:

aws --version
5. AWS Credentials for Jenkins

For EKS deployment, Jenkins needs AWS credentials.

What kubeconfig needs:
EKS cluster name
API server endpoint
Certificate authority
Authentication method
6. Configure AWS Credentials in Jenkins
Step 1: Login Jenkins
http://<jenkins-server>:8080
Step 2: Navigate
Manage Jenkins
   ↓
Credentials
   ↓
System
   ↓
Global credentials (unrestricted)
Step 3: Add Credentials

Click:

Add Credentials
Step 4: Add AWS Secrets

Store AWS credentials as Secret Text:

AWS Access Key
Kind: Secret Text
Secret: AKIAxxxxxxxxxxxx
ID: aws-access-key
AWS Secret Key
Kind: Secret Text
Secret: xxxxxxxxxxxxxxxxx
ID: aws-secret-key

<img width="651" height="492" alt="Screenshot 2026-06-10 174023" src="https://github.com/user-attachments/assets/8379fa2d-4d9a-4f0c-883c-33c9e5d02615" />
<img width="933" height="818" alt="Screenshot 2026-06-10 173852" src="https://github.com/user-attachments/assets/687dfea4-2b40-471b-a3fe-fb2b09bd2ec0" />

7. Best Practice for AWS Access
❌ Not recommended:
Hardcoding AWS credentials
Using long-lived access keys in production
✅ Recommended (Production):
Attach IAM Role to Jenkins EC2 instance
👉 This removes the need to store AWS keys in Jenkins.
8. kubeconfig Best Practice (IMPORTANT)
❌ Do NOT store kubeconfig in Git or Jenkins
✅ BEST APPROACH:

Generate kubeconfig dynamically during pipeline execution.

Why This is Better
- No kubeconfig stored in Jenkins
- No cluster certificate exposure
- Always gets latest EKS endpoint
- Supports multiple clusters easily
- More secure and scalable

9. Jenkins Pipeline (EKS Deployment)
    github link......
10. What This Automatically Creates

When the pipeline runs:

- kubeconfig file is created dynamically
- stored in:
~/.kube/config

inside Jenkins container

**Final Flow**
GitHub Code Push
      ↓
Jenkins Pipeline
      ↓
Build Application
      ↓
Build Docker Image
      ↓
Push to ECR
      ↓
Generate kubeconfig
      ↓
kubectl deploy to EKS
      ↓
Application Running in Kubernetes
