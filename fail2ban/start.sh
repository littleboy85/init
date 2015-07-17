/usr/local/opt/fail2ban/bin/fail2ban-client -x start
syslog -w -T ISO8601 | grep sshd >> /var/log/xzhang-sshd.log
