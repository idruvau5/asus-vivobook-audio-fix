#!/usr/bin/env bash
set -euo pipefail
for _ in $(seq 1 30); do
  id=$(wpctl status 2>/dev/null | awk '/Laptop Speakers - ASUS Natural/ { for (i=1;i<=NF;i++) if ($i ~ /^[0-9]+\.$/) { sub(/\.$/,"",$i); print $i; exit } }')
  if [[ -n ${id:-} ]]; then wpctl set-default "$id"; exit 0; fi
  sleep 1
done
exit 1
