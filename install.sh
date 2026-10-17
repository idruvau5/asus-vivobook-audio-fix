#!/usr/bin/env bash
set -Eeuo pipefail
ROOT=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
[[ $EUID -ne 0 ]] || { echo 'Run as your normal user, not sudo.' >&2; exit 1; }
mkdir -p "$HOME/.config/pipewire/pipewire.conf.d" "$HOME/.local/bin" "$HOME/.config/systemd/user"
install -m 644 "$ROOT/config/asus-speaker-eq.conf" "$HOME/.config/pipewire/pipewire.conf.d/asus-speaker-eq.conf"
install -m 755 "$ROOT/config/set-default-asus-sink.sh" "$HOME/.local/bin/set-default-asus-sink"
cat > "$HOME/.config/systemd/user/asus-audio-default.service" <<'UNIT'
[Unit]
Description=Select ASUS Natural laptop speaker sink
After=pipewire.service pipewire-pulse.service wireplumber.service
[Service]
Type=oneshot
ExecStart=%h/.local/bin/set-default-asus-sink
RemainAfterExit=yes
[Install]
WantedBy=default.target
UNIT
systemctl --user daemon-reload
systemctl --user enable --now asus-audio-default.service
systemctl --user restart pipewire pipewire-pulse wireplumber
sleep 3
"$HOME/.local/bin/set-default-asus-sink" || true
echo 'Installed. Verify with: wpctl status'
