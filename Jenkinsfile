pipeline {
    agent any

    environment {
        DOCKER_REGISTRY_URL = "${params.harbor_url}"
        HARBOR_CREDENTAIL = "${params.harbor_credential}"
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                    docker.withRegistry("http://${DOCKER_REGISTRY_URL}", "${HARBOR_CREDENTAIL}") {
                        def customImage = docker.build("donggu-private-project-1/front-react:${env.BUILD_NUMBER}")
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
                    git credentialsId: "${HARBOR_CREDENTAIL}", url: manifestsRepoUrl, branch: manifestsRepoBranch
                    sh """
                        git pull origin main
                        sed -i 's|harbor.dorong9.com/donggu-private-project-1/front-react:.*|harbor.dorong9.com/donggu-private-project-1/front-react:${env.BUILD_NUMBER}|' test-nginx/web/test-nginx.yaml
                        git add test-nginx/web/test-nginx.yaml
                        git config user.name 'DOLONG9'
                        git config user.email 'bagmy2@gmail.com'
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
