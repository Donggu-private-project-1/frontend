pipeline {
    agent any

    environment {
        // 민감한 정보는 크리덴셜 ID로 참조
        DOCKER_REGISTRY_URL = credentials('docker-registry-url')
        GIT_USER_NAME = credentials('git-user-name')
        GIT_USER_EMAIL = credentials('git-user-email')
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                    docker.withRegistry(env.DOCKER_REGISTRY_URL, 'harbbor_robot') {
                        def customImage = docker.build("${env.DOCKER_REGISTRY_URL}/donggu-private-project-1/front-react:${env.BUILD_NUMBER}")
                        customImage.push()
                    }
                }
            }
        }
        
        stage('Update Manifests') {
            steps {
                script { 
                    // Git repository information for manifests
                    def manifestsRepoUrl = 'https://github.com/Donggu-private-project-1/deploy-argocd.git'
                    def manifestsRepoBranch = 'main'
                    
                    // Checkout manifests repository
                    git credentialsId: 'DOLONG9', url: manifestsRepoUrl, branch: manifestsRepoBranch
                    sh """
                        git pull origin main
                        sed -i 's|harbor.dorong9.com/donggu-private-project-1/front-react:.*|harbor.dorong9.com/donggu-private-project-1/front-react:${env.BUILD_NUMBER}|' test-nginx/web/test-nginx.yaml
                        git add test-nginx/web/test-nginx.yaml
                        git config user.name '${env.GIT_USER_NAME}'
                        git config user.email '${env.GIT_USER_EMAIL}'
                        git commit -m 'test-nginx/web/test-nginx.yaml ${currentBuild.number} image versioning'
                    """
                    withCredentials([gitUsernamePassword(credentialsId: 'DOLONG9')]) {
                       sh "git remote set-url origin https://github.com/Donggu-private-project-1/deploy-argocd.git" 
                       sh "git push origin main"
                    }
                }
            }
        }
    }
}
