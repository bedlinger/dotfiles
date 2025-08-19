#!/bin/sh

STATE_FILE="/tmp/sketchybar_network_toggle_state"
ICON="􀤆"
CURRENT_STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "SSID")

get_ssid() {
  system_profiler SPAirPortDataType | awk '/Current Network/ {getline;$1=$1; gsub(":",""); print;exit}'
}

get_ip() {
  scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1
}

if [ "$CURRENT_STATE" = "SSID" ]; then
  SSID=$(get_ssid)

  if [ -n "$SSID" ]; then
    LABEL="$SSID"
  else
    IP_ADDRESS=$(get_ip)
    if [ -n "$IP_ADDRESS" ]; then
      LABEL="$IP_ADDRESS"
    else
      ICON="􁣡"
      LABEL="No Connection"
    fi
  fi
else
  IP_ADDRESS=$(get_ip)
  if [ -n "$IP_ADDRESS" ]; then
    LABEL="$IP_ADDRESS"
  else
    ICON="􁣡"
    LABEL="No Connection"
  fi
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
