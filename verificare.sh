#!/bin/bash
verifica_ip_dns() {
local host=$1
local ip=$2
local dns_server=$3

local ns_ip=$(nslookup "$host" "$dns_server" 2>/dev/null | awk '/^Address: / {print $2}'
if [ -n "$ns_ip" ] && [ "$ns_ip" !="$ip" ]; then
  echo "[BOGUS IP] Pentru $host avem $ip, dar DNS ($dns_server) returneaza $ns_ip"
fi
}
cat /etc/hosts | while read -r ip host rest; do
[ -z "$ip" ] continue
[ "${ip:0:1}"="#" ] && continue
if [ -n "$ip" ] && [ -n "$host" ]; then
  verificare_ip_dns "$host" "$ip" "8.8.8.8"
fi
done

