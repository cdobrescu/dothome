#!/usr/bin/env bash

set -euo pipefail

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/sleepwatcher"
mkdir -p "$STATE_DIR"

CONNECTED_FILE="$STATE_DIR/connected-devices.txt"

# Save connected devices
blueutil --connected | cut -d, -f1 | cut -d\  -f2 > "$CONNECTED_FILE"

# Disable Bluetooth
blueutil --power 0
