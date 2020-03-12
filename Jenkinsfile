pipeline {
    agent any 
    options { skipDefaultCheckout() }
    stages {
              stage ('Checkout') {
                        echo 'This is a minimal pipeline for DC'
                        echo 'Checking out SCM'
                        checkout scm
                            }
			   
        stage('Maven Build') {
            agent { docker { image 'maven:3.6.3' } } 
            steps {
                echo 'Hello, Maven'
                sh '''
		mvn --version
		mvn clean
		mvn install
		'''
            }
        }
	 stage ('SonarQube Analysis'){
				            def scannerHome = tool 'Sonar-Scanner';
				      withSonarQubeEnv('Sonar') {
				                 sh     "-Dsonar.host.url=https://gbsjenkins.ap-south.containers.mybluemix.net/sonar/ " +
					                "-Dsonar.login=e75570dab8b32166b6273973f0339bac530dd4f3 " +
					                "-Dsonar.projectVersion=${BUILD_NUMBER}-${TEMP_NAME} " +
					                "-Dsonar.projectName=DC-${TEMP_NAME} " +
					                "-Dsonar.projectKey=DC-${TEMP_NAME} " +
					                "-Dsonar.sources=. " +
							"-Dsonar.java.binaries=.
					             }
			                        }
                                      }
                                  }
                    
              /* stage ('ucd deploy Dev') {
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
                 }  */        
