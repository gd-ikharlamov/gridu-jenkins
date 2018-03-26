FROM docker.io/centos:7
LABEL maintainer="Ilya Kharlamov <ikharlamov@griddynamics.com>" \
      description="Centos 7 with jenkins for pmo metabase"
ARG docker_gid=1001
ARG jenkins_link=http://mirrors.jenkins.io/war-stable/latest/jenkins.war
ENV JENKINS_HOME=/var/jenkins/
RUN adduser jenkins -d $JENKINS_HOME && \
    groupadd -g $docker_gid docker && \
    usermod -aG docker jenkins && \
    mkdir -p /usr/share/jenkins
RUN yum install -y java-1.8.0-openjdk-devel unzip git docker ansible && \
    curl -L "$jenkins_link" -o /usr/share/jenkins/jenkins.war
COPY files/ /
COPY plugins.list /usr/share/jenkins/plugins.list
RUN chmod +x /usr/share/jenkins/*.sh && \
    chown -R jenkins:jenkins /usr/share/jenkins/ && \
    /usr/share/jenkins/plugins-install.sh < /usr/share/jenkins/plugins.list
ENTRYPOINT ["/usr/share/jenkins/start-jenkins.sh"]
