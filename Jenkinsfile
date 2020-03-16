pipeline {
agent any
 
tools{
maven 'maven 3.6.3'
jdk 'JAVA 8'
}
 
stages {
    stage ("initialize") {
steps {
sh '''
echo "PATH = ${PATH}"
echo "M2_HOME = ${M2_HOME}"
'''
}
}
     stage ('Build project') {
  steps {
sh 'mvn clean verify'
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
		   rtMaven.tool = 'maven 3.6.3'
		   def buildInfo = rtMaven.run pom: 'pom.xml', goals: 'install'
		   server.publishBuildInfo buildInfo
}
}
}
}
}
