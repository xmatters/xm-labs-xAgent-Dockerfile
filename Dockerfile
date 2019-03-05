FROM centos:latest

RUN bash -c "$(/bin/echo -e 'cat > /etc/yum.repos.d/xmatters.com.repo <<EOF\
\n[xmatters]\
\nname=xMatters, inc. Yum Repo\
\nbaseurl=http://software.xmatters.com/yum\
\nenabled=1\
\ngpgcheck=1\
\ngpgkey=http://software.xmatters.com/yum/RPM-GPG-KEY-xmatters\
\nEOF\n')"

RUN yum -y install xmatters-xa
RUN touch /etc/xmatters/xa/auth.conf
RUN ln -sf /dev/stdout /var/log/xmatters/xmatters-xa/agent-communication-xmatters.log

CMD /opt/xmatters/xa/bin/systemd.start.sh