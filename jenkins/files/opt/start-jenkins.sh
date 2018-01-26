#!/bin/bash
echo "================"
echo "Starting jenkins"
echo "================"
cp -r /opt/init.groovy.d /opt/jenkins/
chown -R jenkins:jenkins /opt/jenkins/
su jenkins -c '/usr/bin/java \
               -Djenkins.install.runSetupWizard=false \
               -Dhudson.model.DirectoryBrowserSupport.CSP="" \
               -Xmx512m \
               -jar /opt/jenkins.war'
