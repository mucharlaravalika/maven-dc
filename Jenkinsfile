pipeline {
    agent any
    tools { 
        maven "Maven-3.6.3"
        jdk "Java-1.8" 
    }
    stages {
	    stage ('Clone Sources') {
            steps {
                git url: 'https://github.com/mucharlaravalika/maven-dc.git'
            }
        }
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                ''' 
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
}
