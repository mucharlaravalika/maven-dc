pipeline {
	agent {
        node {
            label 'DockerIO-2'
        }
     }
        stage ('Checkout code') {
           steps {
            checkout scm
        }
    }
        stage ('Build') {
            steps {
	   sh '''
	        mvn install
		mvn -v
              '''
        }
     }
}
