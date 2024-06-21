pipeline {
    agent any

    stages {

        stage('Build Image') {
            steps {
                script {
                    // Docker 빌드 및 태그
                    docker.withRegistry('http://192.168.20.110:8081', 'harbbor_robot') {
                        def customImage = docker.build("192.168.20.110:8081/donggu-private-project-1/front-react:${env.BUILD_NUMBER}")
                        customImage.push()
                    }
                }
            }
        }
    }
}