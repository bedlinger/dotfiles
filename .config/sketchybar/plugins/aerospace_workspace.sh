#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

IS_FOCUSED=false
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  IS_FOCUSED=true
fi

IS_OCCUPIED=false
if [[ -n "$(aerospace list-windows --workspace "$1")" ]]; then
  IS_OCCUPIED=true
fi

if $IS_FOCUSED; then
  sketchybar --animate tanh 8 --set "$NAME" background.drawing=on background.color=$BRIGHT_ORANGE
else
  sketchybar --set "$NAME" background.drawing=off background.color=$MUTED_ORANGE
fi


if $IS_OCCUPIED; then
  sketchybar --set "$NAME" drawing=on icon="􀕴" label="$1"
else
  if $IS_FOCUSED; then
    sketchybar --set "$NAME" drawing=on icon="􀂒" label="$1"
  else
    sketchybar --set "$NAME" drawing=off
  fi
fi
