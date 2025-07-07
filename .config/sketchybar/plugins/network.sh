#!/bin/sh

STATE_FILE="/tmp/sketchybar_network_toggle_state"

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
SSID=$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')

if [[ $IP_ADDRESS != "" ]]; then
        ICON="􀤆"
        CURRENT_STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "SSID")

        if [ "$CURRENT_STATE" = "SSID" ]; then
                LABEL="$SSID"
        else
                LABEL="$IP_ADDRESS"
        fi
else
        ICON="􁣡"
        LABEL="Not Connected"
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL"
