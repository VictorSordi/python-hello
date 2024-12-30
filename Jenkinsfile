pipeline {
    agent any

    environment {
        TAG = sh(script: 'git describe --abbrev=0',,returnStdout: true).trim()
    }

    stages {
        stage('build docker image'){
        steps{
            sh 'docker build -t python-hello/app:${TAG} .'
            }
        }

        stage('sleep for container deploy'){
        steps{
            sh 'sleep 10'
            }
        }

        stage('Sonarqube validation'){
            steps{
                script{
                    scannerHome = tool 'sonar-scanner';
                }
                withSonarQubeEnv('sonar-server'){
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=python-hello -Dsonar.sources=. -Dsonar.host.url=${env.SONAR_HOST_URL} -Dsonar.token=${env.SONAR_AUTH_TOKEN} -X"
                }
                sh 'sleep 10'
            }
        }

        stage("Quality Gate"){
            steps{
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Upload docker image'){
            steps{
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus-user', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'docker login -u $USERNAME -p $PASSWORD ${NEXUS_URL}'
                        sh 'docker tag python-hello/app:${TAG} ${NEXUS_URL}/python-hello/app:${TAG}'
                        sh 'docker push ${NEXUS_URL}/python-hello/app:${TAG}'
                    }
                }
            }
        }

        stage("Apply kubernetes files"){
            steps{
                sh '/usr/local/bin/kubectl apply -f ./kubernetes/app.yaml'
            }
        }
    }
}