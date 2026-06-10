pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        EKS_CLUSTER = 'prod-cluster'
    }

    stages{
        stage('Build app'){
            steps {
                script {
                    echo "Building the application"
                }
            }
        }

        stage('Build image'){
        steps {
            script {
                echo "Building the docker image"
            }
        }
        }
        stage('Deploy') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_key')

            }
            steps {
                script {
                    // Starting deployment process
                    echo 'Deploying docker image'

                    sh '''

                     # Generate kubeconfig file to connect Jenkins with EKS cluster
                     aws eks update-kubeconfig \
                        --region $AWS_REGION \
                        --name $EKS_CLUSTER

                    # Verify connection to Kubernetes cluster
                    kubectl get nodes

                    # Deploy application to Kubernetes cluster
                    kubectl create deployment nginx-deployment --image=nginx
                   '''

                }
            }
        }
    }

}
   