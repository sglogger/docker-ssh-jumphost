FROM       ubuntu:18.04
MAINTAINER Steven Glogger <steven@glogger.ch>

# Will come from .env file
ARG SSH_USERNAME=nobody
ARG SSH_PASSWORD=none
ARG SSH_PUB_KEY=""
ARG HOSTNAME=localhost
RUN useradd --create-home -m -p "$SSH_PASSWORD" $SSH_USERNAME
RUN mkdir -p /home/$SSH_USERNAME/.ssh
RUN echo $SSH_PUB_KEY > /home/$SSH_USERNAME/.ssh/authorized_keys

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y rsyslog
RUN apt-get install -y openssh-server
RUN apt-get install -y shellinabox
RUN apt-get install -y denyhosts
RUN mkdir /var/run/sshd

# denyhosts
RUN sed -i /etc/denyhosts.conf -e 's/^IPTABLES/#IPTABLES/g'
RUN sed -i /etc/denyhosts.conf -e 's/^PURGE_DENY.*/PURGE_DENY = 3h/g'
RUN sed -i /etc/denyhosts.conf -e 's/^DENY_THRESHOLD_INVALID.*/DENY_THRESHOLD_INVALID = 1/g'
RUN sed -i /etc/denyhosts.conf -e 's/^DENY_THRESHOLD_VALID.*/DENY_THRESHOLD_VALID = 2/g'
RUN sed -i /etc/denyhosts.conf -e 's/^ADMIN_EMAIL/#ADMIN_EMAIL/g'
RUN sed -i /etc/denyhosts.conf -e 's/^#RESET_ON_SUCCESS/RESET_ON_SUCCESS/g'

#rsyslogd - disable kernel logs
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

# nginx config
COPY entrypoint.sh /root/entrypoint.sh

EXPOSE 22
EXPOSE 4200

ENTRYPOINT    ["/root/entrypoint.sh"]
#CMD    ["/usr/sbin/sshd", "-D"]
