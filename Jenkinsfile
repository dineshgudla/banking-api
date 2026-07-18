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
                sh """
                    docker build \
                        -t ${IMAGE_NAME}:${BUILD_NUMBER} \
                        -t ${IMAGE_NAME}:latest \
                        .
                """
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
