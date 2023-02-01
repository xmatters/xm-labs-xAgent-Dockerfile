FROM debian:latest
RUN apt-get update && \
    apt-get install -y wget gnupg && \
    echo 'deb https://software.xmatters.com/apt/ stable main' > /etc/apt/sources.list.d/xmatters.list && \
    wget -qO - https://software.xmatters.com/apt/xmatters_repo.gpg.key | apt-key add - && \
    apt-get update && \
    apt-get install -y xmatters-xa && \
    touch /etc/xmatters/xa/auth.conf && \
    ln -sf /dev/stdout /var/log/xmatters/xmatters-xa/agent-communication-xmatters.log && \
    apt-get remove -y wget gnupg
COPY docker_entrypoint.sh /docker_entrypoint.sh
RUN chmod +x ./docker_entrypoint.sh
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["start"]
