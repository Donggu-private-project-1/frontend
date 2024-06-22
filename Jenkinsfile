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
                    // Git repository information for manifests
                    def manifestsRepoUrl = 'https://github.com/Donggu-private-project-1/deploy-argocd.git'
                    def manifestsRepoBranch = 'main'
                    
                    // Checkout manifests repository
                    git credentialsId: 'DOLONG9', url: manifestsRepoUrl, branch: manifestsRepoBranch
                    
                }
            }
        }
    }
}