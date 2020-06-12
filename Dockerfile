ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["start"]

FROM centos:latest
COPY xmatters.com.repo /etc/yum.repos.d/xmatters.com.repo
RUN yum -y install xmatters-xa && \
    touch /etc/xmatters/xa/auth.conf && \
    ln -sf /dev/stdout /var/log/xmatters/xmatters-xa/agent-communication-xmatters.log
COPY docker_entrypoint.sh /docker_entrypoint.sh
RUN chmod +x ./docker_entrypoint.sh
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["start"]
