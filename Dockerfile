FROM centos:latest

COPY xmatters.com.repo /etc/yum.repos.d/xmatters.com.repo

RUN yum -y install xmatters-xa && \
    touch /etc/xmatters/xa/auth.conf && \
    ln -sf /dev/stdout /var/log/xmatters/xmatters-xa/agent-communication-xmatters.log

COPY docker_entrypoint.sh /docker_entrypoint.sh

ENV FRIENDLY_NAME=""
ENV WEBSOCKET_HOST=""
ENV WEBSOCKET_SECRET=""
ENV OWNER_API_KEY=""

ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["start"]
