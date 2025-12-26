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
                sh '''
                # Stop & remove old container and volume
                docker stop my-postgres || true
                docker rm my-postgres || true
                docker volume rm pgdata || true

                # Run PostgreSQL container
                docker run -d \
                    --name my-postgres \
                    -e POSTGRES_USER=postgres \
                    -e POSTGRES_PASSWORD=vuthy123 \
                    -e POSTGRES_DB=test \
                    -p 5432:5432 \
                    -v pgdata:/var/lib/postgresql/data \
                    postgres:17

                # Wait until PostgreSQL is ready (timeout-safe)
                MAX_RETRIES=30
                COUNT=0
                until docker exec my-postgres pg_isready -U postgres > /dev/null 2>&1; do
                    COUNT=$((COUNT+1))
                    if [ $COUNT -ge $MAX_RETRIES ]; then
                        echo "❌ PostgreSQL did not start in time!"
                        exit 1
                    fi
                    echo "Postgres is not ready yet, sleeping 2s..."
                    sleep 2
                done
                echo "✅ PostgreSQL is ready!"

                # Execute init.sql after DB is ready
                docker exec -i my-postgres psql -U postgres -d test < $WORKSPACE/init.sql
                '''
            }
        }
    }

    post {
        success {
            echo '✅ PostgreSQL deployed successfully with init.sql applied'
        }
        failure {
            echo '❌ Failed to deploy PostgreSQL'
        }
    }
}
