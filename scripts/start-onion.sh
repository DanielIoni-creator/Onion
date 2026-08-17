#!/usr/bin/env bash
set -euo pipefail

SERVICE_DIR="/var/lib/tor/myzubster"
HOSTNAME_FILE="$SERVICE_DIR/hostname"

echo "=== MyZubster Onion ==="

echo "[*] Verifica Tor..."

if ! sudo systemctl is-active --quiet tor@default.service; then
    echo "[*] Avvio Tor..."
    sudo systemctl reset-failed tor@default.service
    sudo systemctl start tor@default.service
fi

if ! sudo systemctl is-active --quiet tor@default.service; then
    echo "[!] Tor non è attivo."
    exit 1
fi

echo "[*] Verifica SOCKS 9050..."

if ! sudo ss -lntp 'sport = :9050' | grep -q '127.0.0.1:9050'; then
    echo "[!] SOCKS 9050 non disponibile."
    exit 1
fi

echo "[*] Verifica Onion Service..."

if ! sudo test -f "$HOSTNAME_FILE"; then
    echo "[!] Onion hostname non trovato: $HOSTNAME_FILE"
    exit 1
fi

ONION_HOST="$(sudo cat "$HOSTNAME_FILE")"

if [ -z "$ONION_HOST" ]; then
    echo "[!] Hostname Onion vuoto."
    exit 1
fi

echo
echo "[OK] Tor attivo"
echo "[OK] SOCKS: 127.0.0.1:9050"
echo "[OK] Onion Service: $SERVICE_DIR"
echo
echo "=== MYZUBSTER ONION ADDRESS ==="
echo "$ONION_HOST"
echo
