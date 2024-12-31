pipeline {
    agent any

    environment {
        TAG = sh(script: 'git describe --abbrev=0', returnStdout: true).trim()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t python-hello/app:${TAG} .'
            }
        }

        stage('Run Tests with Coverage') {
            steps {
                script {
                    sh 'docker run --rm -v ${WORKSPACE}:/app python-hello/app:${TAG} bash -c "cd /app && pytest --cov=app --cov-report=xml:coverage.xml"'
                    sh 'ls -la ${WORKSPACE}/coverage.xml'  
                }
            }
        }

        stage('SonarQube Validation') {
            steps {
                script {
                    scannerHome = tool 'sonar-scanner'
                }
                withSonarQubeEnv('sonar-server') {
                    sh """
                        ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=python-hello \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=${env.SONAR_HOST_URL} \
                        -Dsonar.token=${env.SONAR_AUTH_TOKEN} \
                        -Dsonar.python.coverage.reportPaths=${WORKSPACE}/coverage.xml \
                        -Dsonar.python.version=3.9 \
                        -X
                    """
                }
                sh 'sleep 10'
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Upload Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus-user', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'docker login -u $USERNAME -p $PASSWORD ${NEXUS_URL}'
                        sh 'docker tag python-hello/app:${TAG} ${NEXUS_URL}/python-hello/app:${TAG}'
                        sh 'docker push ${NEXUS_URL}/python-hello/app:${TAG}'
                    }
                }
            }
        }

        stage("Apply Kubernetes Files") {
            steps {
                sh '/usr/local/bin/kubectl apply -f ./kubernetes/app.yaml'
            }
        }
    }
}