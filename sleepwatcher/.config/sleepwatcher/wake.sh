#!/usr/bin/env bash

set -euo pipefail

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/sleepwatcher"
CONNECTED_FILE="$STATE_DIR/connected-devices.txt"

# Enable Bluetooth
blueutil --power 1

[[ -f "$CONNECTED_FILE" ]] || exit 0

# Allow adapter to initialize
sleep 5

while read -r mac; do
    [[ -n "$mac" ]] || continue

    for _ in 1 2 3; do
        blueutil --connect "$mac" && break
        sleep 2
    done
done < "$CONNECTED_FILE"
