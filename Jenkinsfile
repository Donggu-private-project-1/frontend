pipeline {
    agent any
    
    stages {
        stage('Build Image') {
            steps {
                script {
                    docker.withRegistry('http://192.168.20.110:8081', 'harbbor_robot') {
                      def customImage = docker.build("192.168.20.110:8081/donggu-private-project-1/back-springtomcat:${env.BUILD_NUMBER}")
                        customImage.push()
                    }
                }
            }
        }
        
        stage('Update Manifests') {
            steps {
                script { 
                    git credentialsId: 'test', url: 'git@github.com:Donggu-private-project-1/deploy-argocd.git'
                    
                    // Update test-nginx/web/test-nginx.yaml
                    sh "sed -i 's|harbor.dorong9.com/donggu-private-project-1/front-react:.*|harbor.dorong9.com/donggu-private-project-1/front-react:${env.BUILD_NUMBER}|' test-nginx/web/test-nginx.yaml"
                    
                    sh """
                        git config user.name "DOLONG9"
                        git add test-nginx/web/test-nginx.yaml
                        git commit -m 'Update image tag to ${env.BUILD_NUMBER}'
                        git push --set-upstream origin main
                    """
                }
            }
        }
    }
}