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
                    def manifestsRepoUrl = 'git@github.com:Donggu-private-project-1/deploy-argocd.git'
                    def manifestsRepoBranch = 'main'
                    
                    // Checkout manifests repository
                    git credentialsId: 'DOLONG9', url: https://github.com/Donggu-private-project-1/deploy-argocd.git, branch: main
                    
                    // Update test-nginx/web/test-nginx.yaml
                    def manifestFile = 'test-nginx/web/test-nginx.yaml'
                    def manifestContent = readFile(manifestFile)
                    def newImageTag = "harbor.dorong9.com/donggu-private-project-1/front-react:${env.BUILD_NUMBER}"
                    def updatedContent = manifestContent.replaceAll("harbor.dorong9.com/donggu-private-project-1/front-react:.*", newImageTag)
                    writeFile(file: manifestFile, text: updatedContent)
                    
                    // Commit and push changes
                    git add: manifestFile
                    git commit(message: "Update image tag to ${env.BUILD_NUMBER}")
                    git push()
                }
            }
        }
    }
}