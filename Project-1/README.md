# Complete CI/CD Pipeline with Jenkins, Docker, Amazon ECR, and Amazon EKS

This project demonstrates a complete CI/CD pipeline that:

- Builds a Docker image
- Pushes the image to Amazon ECR
- Deploys the application to Amazon EKS
- Performs rolling updates with Kubernetes

---

# Architecture

```text
GitHub
   ↓
Jenkins Pipeline
   ↓
Build Docker Image
   ↓
Push Image to Amazon ECR
   ↓
Deploy to Amazon EKS
   ↓
Kubernetes Pods
   ↓
AWS Load Balancer
   ↓
Users
```

---

# Prerequisites

Install the following tools:

- AWS CLI
- Docker
- kubectl
- eksctl
- Jenkins

To install them:-

# Install eksctl

eksctl is the official command-line tool used to create and manage Amazon EKS clusters.

## Verify Installation

```bash
eksctl version
```

If installed correctly, you should see the eksctl version.

---

## Install eksctl on Windows (Git Bash / PowerShell)

### Download the latest release

```powershell
curl.exe -LO https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Windows_amd64.zip
```

### Extract the file

```powershell
unzip eksctl_Windows_amd64.zip
```

### Move eksctl.exe to a directory in your PATH

For example:

```powershell
mkdir -p /c/Tools
mv eksctl.exe /c/Tools/
```

Add `export PATH=$PATH:/c/Tools` to your Windows Environment Variables PATH if it is not already included.

```powershell
export PATH=$PATH:/c/Tools
```
### Verify Installation

Open a new terminal and run:

```bash
eksctl version
```

---

## Install eksctl on Linux

### Download

```bash
curl --silent --location \
"https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
| tar xz -C /tmp
```

### Move to PATH

```bash
sudo mv /tmp/eksctl /usr/local/bin
```

### Verify

```bash
eksctl version
```

---

## Install eksctl on macOS

Using Homebrew:

```bash
brew tap weaveworks/tap
brew install weaveworks/tap/eksctl
```

Verify:

```bash
eksctl version
```

**Verify installation:**

```bash
aws --version
docker --version
kubectl version --client
eksctl version
```

---

# Step 1: Configure AWS Credentials in Jenkins

Jenkins needs AWS credentials to:

- Authenticate with Amazon ECR
- Push Docker images to ECR
- Connect to the EKS cluster
- Deploy applications to Kubernetes

Instead of hardcoding credentials in the Jenkinsfile, store them securely in Jenkins Credentials Manager.

Navigate to:

```text
Manage Jenkins
    ↓
Credentials
    ↓
System
    ↓
Global Credentials (unrestricted)
```

Click:

```text
Add Credentials
```

Add the following credentials as **Secret Text**:

### AWS Access Key

```text
Kind: Secret Text
Description: AWS Access Key
```
<img width="433" height="259" alt="Screenshot 2026-06-10 173852" src="https://github.com/user-attachments/assets/56ea7391-9cf8-4f19-b98c-01bd188d08e4" />


### AWS Secret Key

```text
Kind: Secret Text
Description: AWS Secret Access Key
```
<img width="351" height="192" alt="Screenshot 2026-06-10 174023" src="https://github.com/user-attachments/assets/a62064c7-424a-4236-982b-6d4be385789c" />

These credentials will be injected securely into the Jenkins pipeline during execution.


# Step 2: Create Amazon ECR Repository

Create an Amazon ECR repository named:

```text
python-application
```

Using AWS Console:

```text
Amazon ECR
    ↓
Repositories
    ↓
Create Repository
```

Repository Name:

```text
python-application
```

Save the repository URI because it will be used in the Jenkins pipeline and Kubernetes deployment files.

---

# Step 3: Create the Amazon EKS Cluster

Create the EKS cluster using eksctl:

```bash
eksctl create cluster \
--name prod-cluster \
--region us-east-1 \
--version 1.33 \
--nodegroup-name workers \
--node-type t3.medium \
--nodes 2 \
--nodes-min 1 \
--nodes-max 3
```

---

## What eksctl Creates Automatically

When using eksctl, AWS automatically creates:

- EKS Control Plane
- VPC
- Public Subnets
- Private Subnets
- Security Groups
- IAM Roles
- Worker Nodes (EC2 Instances)
- Auto Scaling Group

You only specify the desired number of worker nodes. The Auto Scaling Group is created automatically when the node group is created.

---

# Step 4: Verify the EKS Cluster

Verify the cluster exists:

```bash
aws eks list-clusters --region us-east-1
```
<img width="1778" height="188" alt="image" src="https://github.com/user-attachments/assets/dfb44a46-ced9-4002-ae07-769ee517bac5" />

<img width="545" height="144" alt="image" src="https://github.com/user-attachments/assets/31b40f59-2be8-4949-9785-5ff0cf64795a" />

Configure kubectl:

Simple definition:

Configuring kubectl means telling kubectl which Kubernetes cluster to connect to and how to authenticate with it.

```bash
aws eks update-kubeconfig \
--region us-east-1 \
--name prod-cluster
```

Verify connectivity:

```bash
kubectl get nodes
```

Expected output:

```text
NAME                         STATUS
worker-node-1                Ready
worker-node-2                Ready
```

---

# Step 5: Install Required Tools Inside Jenkins Container

Find the Jenkins container:

```bash
docker ps
```
<img width="1406" height="86" alt="Screenshot 2026-06-10 162552" src="https://github.com/user-attachments/assets/7da0e0ee-af65-4432-a31a-34bf5c202683" />

Access the container as root:

```bash
docker exec -u 0 -it jenkins bash
```

Verify:

```bash
whoami
```

Expected:

```text
root
```

---

## Install kubectl

```bash
apt-get update

apt-get install -y curl

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

mv kubectl /usr/local/bin/
```

Verify:

```bash
kubectl version --client
```

---

## Install AWS CLI

```bash
apt-get update

apt-get install -y unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

unzip awscliv2.zip

./aws/install
```

Verify:

```bash
aws --version
```

---

# Step 6: Kubernetes Deployment File

Create a file named:

```text
deployment.yaml
```

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: python-application-deployment

spec:
  replicas: 2

  selector:
    matchLabels:
      app: python-application

  template:
    metadata:
      labels:
        app: python-application

    spec:
      containers:
      - name: python-application
        image: python-application:latest

        ports:
        - containerPort: 5000
```

---

## Deployment File Explanation

### replicas

```yaml
replicas: 2
```

Creates two pods for high availability.

### selector

```yaml
selector:
  matchLabels:
    app: python-application
```

Allows Kubernetes to identify which pods belong to the deployment.

### image

```yaml
image: python-application:latest
```

Specifies the container image that Kubernetes will run.

### containerPort

```yaml
containerPort: 5000
```

Port exposed by the application inside the container.

---

# Step 7: Kubernetes Service File

Create a file named:

```text
service.yaml
```

```yaml
apiVersion: v1
kind: Service

metadata:
  name: python-application-service

spec:
  type: LoadBalancer

  selector:
    app: python-application

  ports:
    - port: 80
      targetPort: 5000
```

---

## Service File Explanation

### LoadBalancer

```yaml
type: LoadBalancer
```

Creates an AWS Elastic Load Balancer automatically.

### port

```yaml
port: 80
```

Port exposed externally.

### targetPort

```yaml
targetPort: 5000
```

Port used by the application container.

---

# Step 8: Deploy the Application

Apply the Kubernetes manifests:

```bash
kubectl apply -f deployment.yaml

kubectl apply -f service.yaml
```

Verify:

```bash
kubectl get pods

kubectl get svc
```

Retrieve the Load Balancer DNS:

```bash
kubectl get svc
```

Once the Load Balancer is provisioned, access the application through the external endpoint.

---

# Step 9: Jenkins Pipeline

Create a Jenkinsfile in the repository root.

```groovy
pipeline {

    agent any

    environment {

        AWS_REGION = 'us-east-1'

        EKS_CLUSTER = 'prod-cluster'

        ECR_REPO = 'python-application'

        // Use Git commit SHA as the image version
        IMAGE_TAG = "${GIT_COMMIT}"
    }

    stages {

        stage('Build Docker Image') {
            steps {

                sh """
                docker build -t $ECR_REPO:$IMAGE_TAG .

                docker tag \
                $ECR_REPO:$IMAGE_TAG \
                $ECR_REPO:latest
                """
            }
        }

        stage('Push Image To ECR') {

            environment {
                AWS_ACCESS_KEY_ID = credentials('aws-access-key')
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }

            steps {

                sh """
                aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin <ECR-REPOSITORY-URI>

                docker push <ECR-REPOSITORY-URI>:$IMAGE_TAG
                """
            }
        }

        stage('Deploy To EKS') {

            environment {
                AWS_ACCESS_KEY_ID = credentials('aws-access-key')
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }

            steps {

                sh """
                aws eks update-kubeconfig \
                --region $AWS_REGION \
                --name $EKS_CLUSTER

                kubectl set image deployment/python-application-deployment \
                python-application=<ECR-REPOSITORY-URI>:$IMAGE_TAG

                kubectl rollout status deployment/python-application-deployment
                """
            }
        }
    }
}
```

---

# Jenkins Pipeline Explanation

### Build Docker Image

Builds the Docker image and tags it using the Git commit SHA.

### Push Image To ECR

Authenticates with Amazon ECR and pushes the image.

### Deploy To EKS

Generates kubeconfig dynamically, updates the deployment image, and performs a rolling update.

### Git Commit Versioning

Using:

```groovy
IMAGE_TAG = "${GIT_COMMIT}"
```

ensures every deployment is tied to a specific Git commit, making troubleshooting and rollback easier.

---

# Final Workflow

```text
Developer Pushes Code
        ↓
GitHub Repository
        ↓
Jenkins Pipeline Triggered
        ↓
Build Docker Image
        ↓
Tag Image Using Git Commit SHA
        ↓
Push Image to Amazon ECR
        ↓
Update Deployment in Amazon EKS
        ↓
Rolling Update of Pods
        ↓
Application Available Through Load Balancer
```

---

# Key Concepts Demonstrated

- Amazon EKS
- Amazon ECR
- Docker
- Jenkins
- CI/CD Pipelines
- Kubernetes Deployments
- Kubernetes Services
- Rolling Updates
- Git-Based Image Versioning
- Infrastructure Automation
