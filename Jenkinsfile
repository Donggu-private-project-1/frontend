pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                // 여기에 빌드 스크립트나 명령어를 추가할 수 있습니다.
                // 예: sh 'make'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Testing...'
                // 여기에 테스트 스크립트나 명령어를 추가할 수 있습니다.
                // 예: sh 'make test'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // 여기에 배포 스크립트나 명령어를 추가할 수 있습니다.
                // 예: sh 'make deploy'
            }
        }
    }
}