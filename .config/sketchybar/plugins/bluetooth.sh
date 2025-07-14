#!/bin/sh

IS_CONNECTED=$(blueutil --connected)

if [ -n "$IS_CONNECTED" ]; then
  sketchybar --set "$NAME" icon="􀉤"
else
  sketchybar --set "$NAME" icon="􂮿"
fi
