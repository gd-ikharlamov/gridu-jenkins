#!/bin/bash
echo "================"
echo "Starting jenkins"
echo "================"
chown -R jenkins:jenkins /opt/jenkins/
su jenkins -c '/usr/bin/java \
               -Dhudson.model.DirectoryBrowserSupport.CSP="" \
               -Xmx512m \
               -jar /opt/jenkins.war'
