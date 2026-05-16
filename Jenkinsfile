pipeline {
    agent any

    environment {
        DOCKER_BUILDKIT = '1'  // Enable BuildKit
    }

    stages {
        stage('Docker Build') {
            steps {
                sh '''
                    set -e  # Exit on any error
                    
                    echo "=== System Information ==="
                    uname -m
                    docker version
                    docker compose version
                    
                    echo "=== Fixing Docker Buildx ==="
                    # Remove corrupted/wrong architecture buildx
                    sudo rm -f /usr/local/lib/docker/cli-plugins/docker-buildx 2>/dev/null || true
                    
                    # Install correct Buildx for current architecture
                    ARCH=$(uname -m)
                    if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
                        BUILDX_ARCH="arm64"
                        echo "Detected ARM64 architecture"
                    else
                        BUILDX_ARCH="amd64"
                        echo "Detected AMD64 architecture"
                    fi
                    
                    echo "Installing Buildx for $BUILDX_ARCH..."
                    DOCKER_BUILDX_VERSION=$(curl -s https://api.github.com/repos/docker/buildx/releases/latest | grep '"tag_name"' | cut -d '"' -f 4)
                    
                    sudo mkdir -p /usr/local/lib/docker/cli-plugins
                    sudo curl -L -o /usr/local/lib/docker/cli-plugins/docker-buildx \
                        "https://github.com/docker/buildx/releases/download/${DOCKER_BUILDX_VERSION}/buildx-${DOCKER_BUILDX_VERSION}.linux-${BUILDX_ARCH}"
                    
                    sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx
                    
                    echo "Buildx Version:"
                    docker buildx version
                    
                    echo "=== Starting Docker Build ==="
                    docker compose build --no-cache --progress=plain
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker compose up -d --force-recreate'
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    echo "=== Running Containers ==="
                    docker ps
                    echo "=== Container Logs (Last 20 lines) ==="
                    docker compose logs --tail=20
                '''
            }
        }
    }

    post {
        failure {
            sh 'docker compose logs || true'
        }
    }
}