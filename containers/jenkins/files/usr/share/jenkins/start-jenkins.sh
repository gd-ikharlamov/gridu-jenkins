#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ ! -d "/var/jenkins/init.groovy.d/" ];
    then
    echo "--- Copying reference files"
    cp -r /usr/share/jenkins/ref/* /var/jenkins/
    else
    echo "--- Jenkins home already exists"
fi

echo "--- Starting jenkins"
chown -R jenkins:jenkins /var/jenkins/
su jenkins -c '/usr/bin/java \
               -Djenkins.install.runSetupWizard=false \
               -Dhudson.model.DirectoryBrowserSupport.CSP="" \
               -Dorg.jenkinsci.plugins.durabletask.BourneShellScript.HEARTBEAT_CHECK_INTERVAL=300 \
               -Dorg.jenkinsci.plugins.docker.workflow.client.DockerClient.CLIENT_TIMEOUT=240 \
               -Xmx256m \
               -jar /usr/share/jenkins/jenkins.war'
