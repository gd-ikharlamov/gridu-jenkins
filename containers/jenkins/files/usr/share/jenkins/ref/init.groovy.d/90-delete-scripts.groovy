#!groovy

println "--- Removing groovy.init.d scripts"

def directory = new File("/var/jenkins/init.groovy.d/")
def filePattern = ~/.*\.groovy/
directory.eachFileRecurse(groovy.io.FileType.FILES)
{ file ->
   if (file ==~ filePattern)
   {
      file.delete()
   }
}
