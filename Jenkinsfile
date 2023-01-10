pipeline {

  agent {
    kubernetes {
      yamlFile 'build-agent.yaml'

    }
  }

  stages {
    stage('Build') {
      agent any
        stage('Compile') {
          steps {
            container('maven') {
              sh 'mvn compile'
            }
          }
        }
      }
    }

    stage('Test') {
      agent any
        stage('Unit Tests') {
          steps {
            container('maven') {
              sh 'mvn test'
            }
          }
        }
      }
    
    stage('Package') {
      agent any
        stage('Create Jarfile') {
          steps {
            container('maven') {
              sh 'mvn package -DskipTests'
            }
          }
        }
      }

    stage('Deploy to Dev') {
      steps {
        sh "echo done"
      }
    }
  }
