#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
  ICON_MAP_SCRIPT="$CONFIG_DIR/icon_map.sh"
  
  APP_NAME="$INFO"

  source "$ICON_MAP_SCRIPT"

  __icon_map "$APP_NAME"

  sketchybar --set "$NAME" icon="$icon_result" label="$APP_NAME"
fi
