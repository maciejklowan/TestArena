FROM nginx:latest

RUN apt-get update \
    && apt-get install -qqy curl python apt-transport-https apt-utils gnupg1 procps \
    && echo 'deb https://packages.amplify.nginx.com/debian/ stretch amplify-agent' > /etc/apt/sources.list.d/nginx-amplify.list \
    && curl -fs https://nginx.org/keys/nginx_signing.key | apt-key add - > /dev/null 2>&1 \
    && apt-get update \
    && apt-get install -qqy nginx-amplify-agent \
    && apt-get purge -qqy curl apt-transport-https apt-utils gnupg1 \
    && rm -rf /var/lib/apt/lists/*

RUN unlink /var/log/nginx/access.log \
    && unlink /var/log/nginx/error.log \
    && touch /var/log/nginx/access.log \
    && touch /var/log/nginx/error.log \
    && chown nginx /var/log/nginx/*log \
    && chmod 644 /var/log/nginx/*log

COPY ./conf/nginx.conf /etc/nginx/
COPY ./conf/stub_status.conf /etc/nginx/conf.d/
COPY ./conf/testarena.dev.conf /etc/nginx/sites-enabled/

COPY entrypoint /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint
ENTRYPOINT ["entrypoint"]