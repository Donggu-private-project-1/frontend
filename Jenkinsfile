pipeline {
    agent any
    
    stages {
        stage('Build Image') {
            steps {
                script {
                    docker.withRegistry('http://192.168.20.110:8081', 'harbbor_robot') {
                      def customImage = docker.build("192.168.20.110:8081/donggu-private-project-1/front-react:${env.BUILD_NUMBER}")
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
                        git config user.name 'DOLONG9'
                        git config user.email 'bagmy2@gmail.com'
                        git commit -m 'kite_sendmanager ${currentBuild.number} image versioning'
                    """
                    withCredentials([gitUsernamePassword(credentialsId: 'github')]) {
                       sh "git remote set-url origin https://github.com/Donggu-private-project-1/deploy-argocd.git" 
                       sh "git push origin main"
                    }
                }
            }
        }
    }
}