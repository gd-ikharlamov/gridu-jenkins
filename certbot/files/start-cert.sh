#!/bin/bash
echo "waiting for nginx container"
until $(curl --output /dev/null --silent --head --fail http://nginx:8080); do
    printf '.'
    sleep 5
done

echo "getting le cert"
        certbot certonly --text --standalone \
                    --agree-tos \
                    --no-eff-email \
                    --preferred-challenges http \
                    -d registry.ml-sandbox.griddynamics.net \
                    --email ikharlamov@griddynamics.com && \
        yes | cp -v -u /etc/letsencrypt/live/registry.ml-sandbox.griddynamics.net/privkey.pem /opt/cert/ml-cert.key && \
        yes | cp -v -u /etc/letsencrypt/live/registry.ml-sandbox.griddynamics.net/fullchain.pem /opt/cert/ml-cert.crt && \
        chown -R 998:998 /opt/cert/
