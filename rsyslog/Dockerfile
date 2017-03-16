FROM alpine:3.5

RUN apk add --no-cache --virtual rsyslog logrotate

EXPOSE 514 514/udp
EXPOSE 514 514/tcp

COPY rsyslog.conf /etc/rsyslog.conf

ENTRYPOINT [ "rsyslogd", "-n" ]

