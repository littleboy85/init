import re

f = open('/var/log/fail2ban.log', 'r')

bad_ips = {}

for line in f:
    pattern = r'\S+ \S+ fail2ban\.actions\S+ WARNING \[ssh-pf\] Ban ([0-9\.]+)'
    match = re.match(pattern, line)
    if match:
        ip = match.group(1)
        if not bad_ips.has_key(ip):
            bad_ips[ip] = 1
        else:
            bad_ips[ip] += 1

items = [item for item in bad_ips.items() if item[1] > 5]
items.sort(key=lambda item: tuple(int(part) for part in item[0].split('.')))

for k, v in items:
    print k

f.close()


