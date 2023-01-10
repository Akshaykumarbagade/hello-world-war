pipeline {
    agent {label 'slave1'}
    stages {
        stage('my Build') {
            steps {
                sh "echo ${BUILD_VERSION}"
                sh 'docker build -t tomcat_build:${BUILD_VERSION} --build-arg BUILD_VERSION=${BUILD_VERSION} .'
            }
        }  
        stage('publish stage') {
            steps {
                sh "echo ${BUILD_VERSION}"
                withCredentials([usernamePassword(credentialsId: 'Dockerhub', passwordVariable: 'DockerhubPassword', usernameVariable: 'DockerhubUser')]) {
                sh "docker login -u ${env.DockerhubUser} -p ${env.DockerhubPassword}"
                sh 'docker tag tomcat_build:${BUILD_VERSION} akshaybagadehub/my_tomcat:${BUILD_VERSION}'
                sh 'docker push akshaybagadehub/my_tomcat:${BUILD_VERSION}'
                }
            }
        } 
        stage( 'my deploy' ) {
        agent {label 'slave2'} 
            steps {
               sh 'docker pull akshaybagadehub/my_tomcat:${BUILD_VERSION}'
               sh 'docker rm -f my_tomcat'
               sh 'docker run -d -p 8080:8080 --name mytomcat akshaybagadehub/my_tomcat:${BUILD_VERSION}'
            }
        }    
    } 
}
