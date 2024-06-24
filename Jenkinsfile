pipeline {
    agent any

    environment {
        DOCKER_REGISTRY_URL = "${params.harbor_url}"
        HARBOR_CREDENTAIL = "${params.harbor_credential}"
        GIT_USER_EMAIL = "${params.git_user_email}"
        GIT_CREDENTIAL = "${params.github_credential}"
    }

    tools {
        nodejs 'NodeJS-21.4.0' // Jenkins에서 구성한 Node.js 도구 이름 사용
    }

    stages {
        stage('Install Dependencies') {
            steps {
                // npm 의존성 설치
                sh 'npm install'
            }
        }

        stage('Build Project') {
            steps {
                // 프로젝트 빌드
                dir('/react') {
                    sh 'npm run build'
                }
            }
        }

        stage('Build Image for donggu-1') {
            steps {
                script {
                    // Copy built artifacts to a temporary directory for Docker build
                    sh "mkdir -p docker_build"
                    sh "cp -r $WORKSPACE/dist ./docker_build"  // Replace 'dist' with your actual build directory

                    docker.withRegistry("http://${DOCKER_REGISTRY_URL}", "${HARBOR_CREDENTAIL}") {
                        def customImage = docker.build("donggu-private-project-1/front-react:${env.BUILD_NUMBER}", "-f Dockerfile/Dockerfile1 ./docker_build")
                        customImage.push()
                    }
                }
            }
        }


        stage('Build Image for test') {
            steps {
                script {
                    docker.withRegistry("http://${DOCKER_REGISTRY_URL}", "${HARBOR_CREDENTAIL}") {
                        def customImage = docker.build("donggu-private-project-1/test:${env.BUILD_NUMBER}", "-f Dockerfile/Dockerfile2 .")
                        customImage.push()
                    }
                }
            }
        }

        stage('Update Manifests for donggu-1') {
            steps {
                script { 
                    // Git repository information for manifests
                    def manifestsRepoUrl = 'https://github.com/Donggu-private-project-1/deploy-argocd.git'
                    def manifestsRepoBranch = 'main'
                    
                    // Checkout manifests repository
                    git credentialsId: "${HARBOR_CREDENTAIL}", url: manifestsRepoUrl, branch: manifestsRepoBranch
                    sh """
                        git pull origin main
                        sed -i 's|harbor.dorong9.com/donggu-private-project-1/front-react:.*|harbor.dorong9.com/donggu-private-project-1/front-react:${env.BUILD_NUMBER}|' donggu-1/web/donggu-1-nginx.yaml
                        git add donggu-1/web/donggu-1-nginx.yaml
                        git config user.name 'DOLONG9'
                        git config user.email "${GIT_USER_EMAIL}"
                        git commit -m 'donggu-1/web/donggu-1-nginx.yaml ${currentBuild.number} image versioning'
                    """
                    withCredentials([gitUsernamePassword(credentialsId: "${GIT_CREDENTIAL}")]) {
                       sh "git remote set-url origin https://github.com/Donggu-private-project-1/deploy-argocd.git" 
                       sh "git push origin main"
                    }
                }
            }
        }

        stage('Update Manifests for test') {
            steps {
                script { 
                    // Git repository information for manifests
                    def manifestsRepoUrl = 'https://github.com/Donggu-private-project-1/deploy-argocd.git'
                    def manifestsRepoBranch = 'main'
                    
                    // Checkout manifests repository
                    git credentialsId: "${HARBOR_CREDENTAIL}", url: manifestsRepoUrl, branch: manifestsRepoBranch
                    sh """
                        git pull origin main
                        sed -i 's|harbor.dorong9.com/donggu-private-project-1/test:.*|harbor.dorong9.com/donggu-private-project-1/test:${env.BUILD_NUMBER}|' test/web/test-nginx.yaml
                        git add test/web/test-nginx.yaml
                        git config user.name 'DOLONG9'
                        git config user.email "${GIT_USER_EMAIL}"
                        git commit -m 'test/web/test-nginx.yaml ${currentBuild.number} image versioning'
                    """
                    withCredentials([gitUsernamePassword(credentialsId: "${GIT_CREDENTIAL}")]) {
                       sh "git remote set-url origin https://github.com/Donggu-private-project-1/deploy-argocd.git" 
                       sh "git push origin main"
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            deleteDir()
        }
    }
}
