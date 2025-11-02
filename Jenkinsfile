pipeline {
  agent any

  environment {
    DOCKER_IMAGE    = 'production_faculty'
  }

  stages {
    stage('Checkout') {
      when { branch 'main' }
      steps {
        git branch: 'main',
            credentialsId: 'GITHUB_SECRET',
            url: 'https://github.com/snagarajan0209/Faculty-Production.git'
      }
    }

    stage('Inject .env') {
      steps {
        withCredentials([file(credentialsId: 'FACULTY_ENV', variable: 'ENV_FILE')]) {
            sh 'cp "$ENV_FILE" .env'
        }
      }
    }

    stage('Build') {
      steps {
        sh 'docker build -t ${DOCKER_IMAGE}:latest .'
      }
    }

    stage('RUN') {
      steps {
        sh 'make up'
      }
    }
  }

  post {
    always {
      script {
        echo "📅 Pipeline finished at ${new Date().format("yyyy-MM-dd HH:mm:ss")}"
      }
    }
    success {
      echo "✅ Build succeeded! ${DOCKER_IMAGE}:latest"
    }
    failure {
      echo "❌ Build failed!"
    }
  }
}
