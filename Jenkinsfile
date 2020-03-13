node ('DockerIO-2'){
  withEnv([
    'APP_HOSTNAME=fusetest.apps.met-police.poc-optimus.co.uk',
    'APP_NAME=fusetest',
    'USERNAME=rmucharl@in.ibm.com',
    'IMAGE_NAME=maven-hello-world',
    'VERSION=1.0',
    'DOCKER_REPO=devopscommandertest',
    'PASSWORD=AKCp5ekcGGoPqCFDpH9uaW3xCnchWJEhEhc92tQtiFWrd2yQwRG1jmq8LokmEABhP1DHDcJzh',
    'HOST=gbsartifactorytest.in.dst.ibm.com',
    'OSE_SERVER=https://c100-e.us-south.containers.cloud.ibm.com:32734',
    'TOKEN=F8BrVcieS-uoSeQeVMYEitmzE3Ow87K5KhUs812dazs',
    'DEVEL_PROJ_NAME=dc-template',
    'DEPLOYCONFIG= s2i-fuse75-spring-boot-camel-xml',
    //"SONARSCANNER=${tool name: 'sonarqube', type: 'hudson.plugins.sonar.SonarRunnerInstallation'}/",
    //"PATH+OC=${tool name: 'oc3.11.0', type: 'oc'}/",
    'GITCREDID=rmucharl(DC)',
    'GITBRANCH=master',
    'GITURL=https://github.com/mucharlaravalika/maven-dc.git']){
    
        stage('Checkout code and build'){
                git url: "${GITURL}",credentialsId: "${GITCREDID}"
        }
        stage ('SonarQube analysis') {
            // step ([$class: 'CopyArtifact', projectName: 'checkout code and build', filter: '**/*']);
                withSonarQubeEnv ('Sonar') {
                   // sh """${SONARSCANNER}/bin/sonar-scanner"""
                  sh """/opt/sonar-runner-2.4/bin/sonar-runner"""
                  
                }
        }
        
       // stage("Quality Gate Check"){
       //   timeout(time: 5, unit: 'MINUTES') {
         //     def qg = waitForQualityGate()
           //   if (qg.status != 'OK') {
             //     error "Pipeline aborted due to quality gate failure: ${qg.status}"
               // }
            //}
        //}
        stage("maven build")
	  {
		  sh"""
		  mvn -v
		  mvn install
		  mvn package
		  """		  
	  }  
        stage("docker build")
        {
            sh""" docker login -u ${USERNAME} -p${PASSWORD} ${HOST}
            docker build -t ${HOST}/${DOCKER_REPO}/${IMAGE_NAME}:${VERSION} .
            docker push ${HOST}/${DOCKER_REPO}/${IMAGE_NAME}:${VERSION}
            """
         // sh """docker login -u ${USERNAME} -p${PASSWORD} ${HOST}"""
        }
       /*stage("openshift deployment")
       {
           sh"""
           oc login ${OSE_SERVER} --token=${TOKEN}
           oc project ${DEVEL_PROJ_NAME}
           oc apply -f deploy.yaml
           // """
        //}
        //stage("unit and integration testing")
        //{
          //  sh """npm run test-with-mocha-coverage"""
        //}*/
    }
}
