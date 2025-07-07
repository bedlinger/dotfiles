#!/bin/sh

STATE_FILE="/tmp/sketchybar_network_toggle_state"

CURRENT_STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "IP")

if [ "$CURRENT_STATE" = "IP" ]; then
  echo "SSID" > "$STATE_FILE"
else
  echo "IP" > "$STATE_FILE"
fi

sketchybar --trigger network_update
