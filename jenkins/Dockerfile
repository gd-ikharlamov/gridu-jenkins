FROM docker.io/centos:7
ARG docker_gid=1001
ARG jenkins_link=http://mirrors.jenkins.io/war-stable/latest/jenkins.war
ENV JENKINS_HOME=/opt/jenkins/
RUN yum install -y java-1.8.0-openjdk git docker ansible && \
    curl -L "$jenkins_link" -o /opt/jenkins.war
    #&& \
COPY files/ /
RUN adduser jenkins -d /opt/jenkins && \
    groupadd -g $docker_gid docker && \
    usermod -aG docker jenkins && \
    chmod +x /opt/start-jenkins.sh && \
    mkdir -p /opt/jenkins && \
    chown -R jenkins:jenkins /opt/jenkins.war
ENTRYPOINT ["/opt/start-jenkins.sh"]
