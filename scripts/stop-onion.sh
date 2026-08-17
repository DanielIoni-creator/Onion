#!/usr/bin/env bash
set -euo pipefail

sudo systemctl stop tor@default.service
echo "[OK] Tor/MyZubster Onion fermato."
