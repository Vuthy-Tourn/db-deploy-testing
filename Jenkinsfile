pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Vuthy-Tourn/db-deploy-testing'
            }
        }

        stage('Deploy PostgreSQL') {
            steps {
                sh """
                # Stop and remove existing container if it exists
                docker stop my-postgres || true
                docker rm my-postgres || true

                # Run PostgreSQL container
                docker run -d \
                    --name my-postgres \
                    -e POSTGRES_USER=postgres \
                    -e POSTGRES_PASSWORD=vuthy123 \
                    -e POSTGRES_DB=test \
                    -p 5432:5432 \
                    postgres:17
                """
            }
        }
    }

    post {
        success {
            echo '✅ PostgreSQL deployed successfully'
        }
        failure {
            echo '❌ Failed to deploy PostgreSQL'
        }
    }
}
