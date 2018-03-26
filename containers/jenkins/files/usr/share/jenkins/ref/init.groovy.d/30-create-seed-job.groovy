#!groovy
import javaposse.jobdsl.dsl.DslScriptLoader
import javaposse.jobdsl.plugin.JenkinsJobManagement

println "--- adding seed job"

def jobDslScript = new File('/var/jenkins/init.groovy.d/jobs/seed.groovy.dsl')
def workspace = new File('.')

def jobManagement = new JenkinsJobManagement(System.out, [:], workspace)
new DslScriptLoader(jobManagement).runScript(jobDslScript.text)
