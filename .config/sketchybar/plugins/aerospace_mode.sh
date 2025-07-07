#!/usr/bin/env bash

case $CURRENT_MODE in
  service)
    LABEL="S"
    ;;
  application)
    LABEL="A"
    ;;
  *)
    LABEL="M"
    ;;
esac

sketchybar --set "$NAME" label="[$LABEL]"
