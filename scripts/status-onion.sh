#!/usr/bin/env bash
set -euo pipefail

echo "=== TOR STATUS ==="
systemctl is-active tor@default.service || true

echo
echo "=== SOCKS 9050 ==="
sudo ss -lntp 'sport = :9050' || true

echo
echo "=== ONION HOSTNAME ==="
if [ -f /var/lib/tor/myzubster/hostname ]; then
    sudo cat /var/lib/tor/myzubster/hostname
else
    echo "hostname non trovato"
fi
