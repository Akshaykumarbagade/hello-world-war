pipeline {
  agent { label 'jenkinsone'}
  stages { 
    stage('checkout') {
      steps {
          sh 'rm -rf hello-world-war'
          sh 'git clone https://github.com/Srikanthkittane/hello-world-war.git '
      }
    } 
    stage ('build') {
      steps {
        script {
          dir('hello-world-war') {
              sh 'docker build -t tomimage:${BUILD_NUMBER} .'
              sh 'docker tag tomimage:${BUILD_NUMBER} srikanthkittane/tomcat1.0:${BUILD_NUMBER}'
          }
        }
      }
    }
    stage ('publish') {
      steps {
          sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u srikanthkittane --password=8800507102'
          sh 'docker push srikanthkittane/tomcat1.0:${BUILD_NUMBER}'
      }
   }
    stage ('deploy') {
      agent { label 'jenkinstwo' }
      steps {
          sh 'docker rm -f mytomcat'
          sh 'sleep 5'
          sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u srikanthkittane --password=8800507102'
          sh 'docker pull srikanthkittane/tomcat1.0:${BUILD_NUMBER}'
          sh 'docker run -d --name mytomcat -p 8084:8080 srikanthkittane/tomcat1.0:${BUILD_NUMBER}'
      }
    }   
 }
}
