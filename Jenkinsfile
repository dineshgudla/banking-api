pipeline {

    agent {
        label 'docker'
    }

    environment {

        IMAGE_NAME = 'banking-api'

        AWS_REGION = 'ap-south-1'

        AWS_ACCOUNT_ID = 'YOUR_AWS_ACCOUNT_ID'

        ECR_REPOSITORY = 'banking-api'

        REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Unit Test') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Docker Build') {

            steps {

                script {

                    def GIT_COMMIT_SHORT = sh(
                        script: 'git rev-parse --short HEAD',
                        returnStdout: true
                    ).trim()

                    def IMAGE_BUILD  = "${IMAGE_NAME}:${BUILD_NUMBER}"
                    def IMAGE_LATEST = "${IMAGE_NAME}:latest"
                    def IMAGE_COMMIT = "${IMAGE_NAME}:${GIT_COMMIT_SHORT}"

                    echo "=========================================="
                    echo "Building Docker Image"
                    echo "=========================================="
                    echo "Build Number : ${BUILD_NUMBER}"
                    echo "Git Commit   : ${GIT_COMMIT_SHORT}"
                    echo "Image Name   : ${IMAGE_NAME}"
                    echo "=========================================="

                    sh """
                        docker build \
                            -t ${IMAGE_BUILD} \
                            -t ${IMAGE_LATEST} \
                            -t ${IMAGE_COMMIT} \
                            .
                    """

                }

            }

        }

    }

    post {

        success {
            echo "Pipeline executed successfully."
        }

        failure {
            echo "Pipeline failed."
        }

        always {
            cleanWs()
        }

    }

}
