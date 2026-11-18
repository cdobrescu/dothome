#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/sleepwatcher"

SLEEP_SCRIPT="$CONFIG_DIR/sleep.sh"
WAKE_SCRIPT="$CONFIG_DIR/wake.sh"

PLIST="$(find "$HOME/Library/LaunchAgents" \
    -maxdepth 1 \
    -name '*.sleepwatcher.plist' \
    -print -quit)"

[[ -n "$PLIST" ]] || {
    echo "No sleepwatcher plist found in $HOME/Library/LaunchAgents"
    exit 1
}

[[ -x "$SLEEP_SCRIPT" ]] || {
    echo "Missing executable sleep script: $SLEEP_SCRIPT"
    exit 1
}

[[ -x "$WAKE_SCRIPT" ]] || {
    echo "Missing executable wake script: $WAKE_SCRIPT"
    exit 1
}

# Reuse the currently configured binary path.
SW_BIN="$(plutil -extract ProgramArguments.0 raw -o - "$PLIST")"

cp "$PLIST" "$PLIST.bak"

echo "Updating $PLIST"
echo "  sleep -> $SLEEP_SCRIPT"
echo "  wake  -> $WAKE_SCRIPT"

launchctl bootout "gui/$(id -u)" "$PLIST" 2>/dev/null || true

plutil -replace ProgramArguments -json \
"[
  \"$SW_BIN\",
  \"-s\",
  \"$SLEEP_SCRIPT\",
  \"-w\",
  \"$WAKE_SCRIPT\"
]" \
"$PLIST"

plutil -lint "$PLIST"

launchctl bootstrap "gui/$(id -u)" "$PLIST"

echo
echo "SleepWatcher reloaded successfully."
echo
echo "Current arguments:"
plutil -extract ProgramArguments json -o - "$PLIST"
