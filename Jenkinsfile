pipeline {

    agent {
        label 'docker'
    }

    environment {
        IMAGE_NAME = 'banking-api'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
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

                    echo "Building Docker image..."
                    echo "Build Number : ${BUILD_NUMBER}"
                    echo "Git Commit   : ${GIT_COMMIT_SHORT}"

                    sh """
                        docker build \
                            -t ${IMAGE_NAME}:${BUILD_NUMBER} \
                            -t ${IMAGE_NAME}:latest \
                            -t ${IMAGE_NAME}:${GIT_COMMIT_SHORT} \
                            .
                    """
                }
            }
        }
    }

    post {

        success {
            echo 'Application built successfully.'
        }

        failure {
            echo 'Build failed.'
        }

        always {
            cleanWs()
        }
    }
}
