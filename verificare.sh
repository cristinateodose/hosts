#!/bin/bash
cat /etc/hosts | while read -r ip host rest; do
[ -z "$ip" ] && continue
[ "${ip:0:1)"="#" ] && continue
if [ -n "$ip" ] && [ -n "$host" ]; then
ns_ip=$(nslookup "$host" 2>/dev/null | awk '/^Address: / {print $2}' | tail -n 1)
if [ -n "$ns_ip" ] && [ "$ns_ip" !="$ip" ]; then 
echo "Bogus IP for $host in /etc/hosts!"
fi
fi
done

