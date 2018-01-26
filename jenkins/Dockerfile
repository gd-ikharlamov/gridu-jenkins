FROM docker.io/centos:7
ARG docker_gid=1001
ARG jenkins_link=http://mirrors.jenkins.io/war-stable/latest/jenkins.war
ARG install_plugins_link=https://raw.githubusercontent.com/jenkinsci/docker/master/install-plugins.sh
ENV JENKINS_HOME=/opt/jenkins/
COPY files/ /
RUN yum install -y java-1.8.0-openjdk-headless git docker ansible && \
    curl -L "$jenkins_link" -o /opt/jenkins.war && \
    adduser jenkins -d /opt/jenkins && \
    groupadd -g $docker_gid docker && \
    usermod -aG docker jenkins && \
    chmod +x /opt/start-jenkins.sh && \
    mkdir -p /opt/jenkins && \
    chown -R jenkins:jenkins /opt/jenkins.war && \
    curl -L "install_plugins_link" -o /opt/install-plugins.sh && \
    sed "s/\/usr\/share\/jenkins/\/opt/g" -i /opt/install-plugins.sh && \
    chmod +x /opt/install-plugins.sh && \
    /opt/install-plugins.sh ansible git workflow-aggregator job-dsl role-strategy google-login
ENTRYPOINT ["/opt/start-jenkins.sh"]
