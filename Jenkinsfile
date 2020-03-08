pipeline {
   agent any
    options { skipDefaultCheckout() }
    stages {
        stage ('Build Stage') {
            agent none
            steps {
                script {
                    stage ('Checkout') {
                        echo 'This is a minimal pipeline for PayGo'
                        echo 'Checking out SCM'
                        checkout scm

                        sh '''
                            echo "PATH = ${PATH}"
                            echo "M2_HOME = ${M2_HOME}"
                        '''
		    }
                    stage ('BUILD') {

                        echo 'Installing node modules'
                        sh 'whoami'
                        sh 'npm install'
                    }
                    
                   stage ('SonarQube Analysis'){
				            //def scannerHome = tool 'Sonar-Scanner';
				        /*
			                withSonarQubeEnv('GBSSONAR') {
				                sh "/opt/sonar-runner-2.4/bin/sonar-runner " +
					                "-Dsonar.host.url=https://gbssonar.edst.ibm.com/sonar " +
					                "-Dsonar.login=e75570dab8b32166b6273973f0339bac530dd4f3 " +
					                "-Dsonar.projectVersion=${BUILD_NUMBER}-${TEMP_NAME} " +
					                "-Dsonar.projectName=HCIL-${TEMP_NAME} " +
					                "-Dsonar.projectKey=HCIL-${TEMP_NAME} " +
					                "-Dsonar.sources=. " +
					                "-Dsonar.exclusions=node_modules/** "
					                // "-Dsonar.java.binaries=/home/jenkins/workspace/TemplateProjects/MobileAdapter-Java/UserLogin/target/classes " +
			                }
			                */
                        }
                    
               stage ('ucd deploy Dev') {
                    echo 'started deploying in UCD Dev env'
                    step([  $class: 'UCDeployPublisher',
                    siteName: 'IBM GBS UCD',
                    component: [
                    $class: 'com.urbancode.jenkins.plugins.ucdeploy.VersionHelper$VersionBlock',
                    componentName: '${COMP_NAME}',
                    delivery: [
                    $class: 'com.urbancode.jenkins.plugins.ucdeploy.DeliveryHelper$Push',
                    pushVersion: '${BUILD_NUMBER}-${TEMP_NAME}',
                    baseDir: 'workspace//HCIL//${COMP_NAME}',
                             ]
                              ],
                    deploy: [
                 $class: 'com.urbancode.jenkins.plugins.ucdeploy.DeployHelper$DeployBlock',
                 deployApp: 'HCIL',
                 deployEnv: 'Dev',
                 deployProc: 'deploy-${COMP_NAME}',
                 deployVersions: '${COMP_NAME}:${BUILD_NUMBER}-${TEMP_NAME}',
                 deployOnlyChanged: false
                         ]
                           ])
                  }          
			
                }
            }
        }
    }
}
