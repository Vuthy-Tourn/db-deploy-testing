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
        docker stop my-postgres || true
        docker rm my-postgres || true
        docker volume rm pgdata || true

        docker run -d \\
            --name my-postgres \\
            -e POSTGRES_USER=postgres \\
            -e POSTGRES_PASSWORD=vuthy123 \\
            -e POSTGRES_DB=test \\
            -p 5432:5432 \\
            -v pgdata:/var/lib/postgresql/data \\
            -v \$(pwd)/init.sql:/docker-entrypoint-initdb.d/init.sql \\
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
