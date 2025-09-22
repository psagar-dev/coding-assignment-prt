pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        ECR_REPO = '975050024946.dkr.ecr.ap-south-1.amazonaws.com/sagar-app-repo'
        IMAGE_TAG = "${BUILD_NUMBER}"
        EKS_CLUSTER_NAME = 'flask-eks-cluster'
        DOCKER_IMAGE = "${ECR_REPO}:${IMAGE_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo 'Code checked out from Git'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build --no-cache -t flask-app-repo .'
            }
        }

        stage('Push to ECR') {
            steps {
                withAWS(region: AWS_REGION, credentials: 'aws-credentials') {
                    sh """
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO}
                    docker tag flask-app-repo:latest ${DOCKER_IMAGE}
                    docker push ${DOCKER_IMAGE}
                    """
                    echo 'Docker image pushed to ECR'
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withAWS(region: AWS_REGION, credentials: 'aws-credentials') {
                    sh """
                    aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME} --region ${AWS_REGION}
                    sed "s|<IMAGE_NAME>|${DOCKER_IMAGE}|g" kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    """
                    echo 'Deployed to EKS'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
        always {
            sh 'docker system prune -f'
            echo 'Cleaned up Docker resources'
        }
    }
}