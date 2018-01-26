FROM docker.io/centos:7
COPY files/start-cert.sh /opt/
RUN yum install -y epel-release && \
    yum install -y certbot && \
    yum clean all && \
    chmod +x /opt/start-cert.sh
# ENTRYPOINT ["/opt/start-cert.sh"]
ENTRYPOINT ["/usr/bin/sleep"]
CMD ["infinity"]
