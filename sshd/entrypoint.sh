#!/bin/sh
/usr/sbin/rsyslogd
/usr/bin/shellinaboxd -t -b
/usr/sbin/denyhosts --daemon --config=/etc/denyhosts.conf
/usr/sbin/sshd -D
