FROM docker.io/centos:7
COPY files/ /
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y nginx httpd-tools && \
    chown -R nginx:nginx /etc/nginx/
USER nginx
ENTRYPOINT ["nginx"]
