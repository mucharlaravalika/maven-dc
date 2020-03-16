pipeline {
	agent any
tools{
maven 'maven'
jdk 'java'
}
 
stages {
     stage ('Build project') {
  steps {
sh '''
java -version
mvn -v
mvn clean verify
mvn compile package
'''
            }
         }
stage ('SonarQube analysis') {
                withSonarQubeEnv ('Sonar') {
                  sh '''/opt/sonar-runner-2.4/bin/sonar-runner"""
                }	
             }
stage ('Docker Build') {
           steps {
            sh '''
	    docker login -u ${USERNAME} -p${PASSWORD} ${HOST}
            docker build -t ${HOST}/${DOCKER_REPO}/${IMAGE_NAME}:${VERSION} .
            docker push ${HOST}/${DOCKER_REPO}/${IMAGE_NAME}:${VERSION}
            '''
            }
	}
stage ('openshift deployment') {
       steps {
          sh '''
           oc login ${OSE_SERVER} --token=${TOKEN}
           oc project ${DEVEL_PROJ_NAME}
           oc apply -f deploy.yaml
        '''
	   }
        }
}
environment{
     APP_HOSTNAME=fusetest.apps.met-police.poc-optimus.co.uk',
    'APP_NAME=fusetest',
    'USERNAME=rmucharl@in.ibm.com',
    'IMAGE_NAME=maven-hello-world',
    'VERSION=1.0',
    'DOCKER_REPO=devopscommandertest',
    'PASSWORD=AKCp5ekcGGoPqCFDpH9uaW3xCnchWJEhEhc92tQtiFWrd2yQwRG1jmq8LokmEABhP1DHDcJzh',
    'HOST=gbsartifactorytest.in.dst.ibm.com',
    'OSE_SERVER=https://c100-e.us-south.containers.cloud.ibm.com:32734',
    'TOKEN=F8BrVcieS-uoSeQeVMYEitmzE3Ow87K5KhUs812dazs',
    'DEVEL_PROJ_NAME=dc-template'
	}
}
