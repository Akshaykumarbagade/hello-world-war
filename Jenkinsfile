pipeline {
    agent {label 'slave1'}
    stages {
        stage('my Build') {
            steps {
                sh "echo ${BUILD_VERSION}"
                sh 'docker build -t tomcat_build .'
            }
        }  
        stage('publish stage') {
            steps {
                sh "echo ${BUILD_VERSION}"
                sh "docker login -u akshaybagadehub -p Docker@123"
                sh 'docker tag tomcat_build:1.0 akshaybagadehub/my_tomcat:1.0'
                sh 'docker push akshaybagadehub/my_tomcat:1.0'
                }
            }
        } 
        stage( 'my deploy' ) {
        agent {label 'slave2'} 
            steps {
               sh 'docker pull akshaybagadehub/my_tomcat:1.0'
               sh 'docker rm -f my_tomcat'
               sh 'docker run -d -p 8080:8080 --name mytomcat akshaybagadehub/my_tomcat:1.0'
            }
        }    
    } 
}
