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
'''
}
}
   stage ('Artifactory Deploy'){
     when {
          branch "master"
          }
      steps{
          script {
		   def server = Artifactory.server('artifactory')
		   def rtMaven = Artifactory.newMavenBuild()
		   rtMaven.resolver server: server, releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot'
		   rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'
		   rtMaven.tool = 'maven'
		   def buildInfo = rtMaven.run pom: 'pom.xml', goals: 'install'
		   server.publishBuildInfo buildInfo
}
}
}
}
}
