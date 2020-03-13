node ('DockerIO-2'){
  def rtMaven = Artifactory.newMavenBuild()
  def buildInfo
  withEnv([
    //'APP_HOSTNAME= fusetest.apps.met-police.poc-optimus.co.uk',
    //'APP_NAME= fusetest',
    'USER_NAME= rmucharl@in.ibm.com',
    'PASSWORD= AKCp5ekcGGoPqCFDpH9uaW3xCnchWJEhEhc92tQtiFWrd2yQwRG1jmq8LokmEABhP1DHDcJzh',
    'HOST= gbsartifactorytest.in.dst.ibm.com/artifactory/devopscommandertest',
    //'OSE_SERVER= https://c100-e.us-south.containers.cloud.ibm.com:32734',
    //'TOKEN=eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkYy10ZW1wbGF0ZSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkYy10ZW1wbGF0ZS10b2tlbi1zMnp2ZyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJkYy10ZW1wbGF0ZSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImE4NDZkYmVjLTVkM2EtMTFlYS1hMjVkLThhNGExYmFkMjViNSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkYy10ZW1wbGF0ZTpkYy10ZW1wbGF0ZSJ9.fleJtzmGc5RNxRhZjI2Lb67prVgl8HUK1tEG94M_cEIA1Tk6PcpkdlPVWfFKAaeLQHqOwryHbePKrCSctxPlcJXgzaZFfKqDRglu4ZRJYFzCL0D_hULtD1G15lq3sNbbRld3w_8YBTk8KAOXzp9ampvYck-ytfu3IUnu2XFUQdSzt2TlwboGsG7KJMLAAbMRGVrSYhwUJOkCsRNhuHw3FnyZbcld2WAQlVTo1-hC9UwJduJJmHo1IO6bsiw4_xAohHekAXuW5Eapowe6X8GZUy9OYhlrySUmM_Up6ZQyy0RJlMXOq0Allt9LQx_8qI4M6o6gNelTS1XSPOaVylOmuA',
    //'DEVEL_PROJ_NAME= dc-template',
    //'DEPLOYCONFIG= s2i-fuse75-spring-boot-camel-xml',
    //"SONARSCANNER=${tool name: 'sonarqube', type: 'hudson.plugins.sonar.SonarRunnerInstallation'}/",
    //"PATH+OC=${tool name: 'oc3.11.0', type: 'oc'}/",
    'GITCREDID=rmucharl(DC)',
    'GITBRANCH=master',
    'GITURL=https://github.com/mucharlaravalika/maven-dc.git'])
    
        stage('Checkout code and build'){
                git url: "${GITURL}",credentialsId: "${GITCREDID}"
        }
        stage ('SonarQube analysis') {
            // step ([$class: 'CopyArtifact', projectName: 'checkout code and build', filter: '**/*']);
                withSonarQubeEnv ("SonarQube(Sonar)") {
                   // sh """${SONARSCANNER}/bin/sonar-scanner"""
                  sh """/opt/sonar-runner-2.4"""
                  
                }
        }
        
        stage("Quality Gate Check"){
          timeout(time: 5, unit: 'MINUTES') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
                }
            }
        }
	stage("Maven build") {
        buildInfo = rtMaven.run pom: 'maven-dc/pom.xml', goals: 'clean install package'
                }
      
	stage("docker build")
        {
          sh """docker login -u ${USERNAME} -p${PASSWORD} ${HOST}
	  docker build -t ${HOST}/helloworld-maven:1.0 .
          docker push ${HOST}/helloworld-maven:1.0 .
	  """
        }
       // stage("openshift deployment")
       // {
         //   sh"""
           // oc login ${OSE_SERVER} --token=${TOKEN}
           // oc project ${DEVEL_PROJ_NAME}
           // oc apply -f deploy.yaml
           // """
        //}
        //stage("unit and integration testing")
        //{
          //  sh """npm run test-with-mocha-coverage"""
        //}
    }
