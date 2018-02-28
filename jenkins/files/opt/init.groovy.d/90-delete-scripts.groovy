import org.apache.commons.io.FileUtils

File folder = new File("/opt/jenkins/init.groovy.d/")
FileUtils.cleanDirectory(folder)
