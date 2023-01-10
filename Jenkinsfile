pipeline {
  agent {
    kubernetes {
      yamlFile 'build-agent.yaml'
    }
  }
  stages {
    stage('Build') {
      agent any
      steps {
        container('maven') {
          sh 'mvn compile'
        }
      }
    }
    stage('Test') {
      agent any
      steps {
        container('maven') {
          sh 'mvn test'
        }
      }
    }
    stage('Package') {
      agent any
      steps {
        container('maven') {
          sh 'mvn package -DskipTests'
        }
      }
    }
    stage('Static Analysis') {
      steps {
        container('sonarqube') {
          sh 'sonar-scanner'
        }
      }
    }
    stage('Deploy to Dev') {
      steps {
        // TODO
        sh "echo done"
      }
    }
  }
}
