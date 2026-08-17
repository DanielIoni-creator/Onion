#!/usr/bin/env bash
set -euo pipefail

if [ -f /var/lib/tor/myzubster/hostname ]; then
    sudo cat /var/lib/tor/myzubster/hostname
else
    echo "Onion service non inizializzato" >&2
    exit 1
fi
