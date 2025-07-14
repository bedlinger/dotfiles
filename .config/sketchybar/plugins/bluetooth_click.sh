#!/bin/zsh

toggle_bluetooth_devices() {
  source "$HOME/.config/sketchybar/colors.sh"

  ALL_DEVICES=$(system_profiler SPBluetoothDataType | grep "^        .*:$" | sed 's/^[[:space:]]*//;s/:$//')
  CONNECTED_DEVICES=$(system_profiler SPBluetoothDataType | awk '/Connected:/{f=1} /Not Connected:|Devices \(/{f=0} f && /^        .*:$/ {gsub(/^[ \t]+|:$/, ""); print}')

  declare -A connected_map
  while IFS= read -r device; do
      [ -n "$device" ] && connected_map["$device"]=1
  done <<< "$CONNECTED_DEVICES"

  args=(--remove '/bluetooth.device\.*/' --set "$NAME" popup.drawing=toggle)
  COUNTER=0

  while IFS= read -r device; do
    if [ -z "$device" ]; then continue; fi

    if [[ ${connected_map["$device"]} ]]; then
      COLOR=$WHITE
      args+=(--add item "bluetooth.device.$COUNTER" popup."$NAME"   \
             --set "bluetooth.device.$COUNTER" label="${device}"    \
                                               label.color="$COLOR" \
                                               click_script="blueutil --disconnect \"${device}\"; sketchybar --set \"$NAME\" popup.drawing=off")
    else
      COLOR=$GRAY
      args+=(--add item "bluetooth.device.$COUNTER" popup."$NAME"   \
             --set "bluetooth.device.$COUNTER" label="${device}"    \
                                               label.color="$COLOR" \
                                               click_script="blueutil --connect \"${device}\"; sketchybar --set \"$NAME\" popup.drawing=off")
    fi

    COUNTER=$((COUNTER + 1))
  done <<< "$ALL_DEVICES"

  sketchybar -m "${args[@]}" > /dev/null
}

toggle_bluetooth_devices
