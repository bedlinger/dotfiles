#!/usr/bin/env zsh

MAX_LENGTH=64
# Function to update the track information
update_track() {
    # Exit if Spotify is not providing information
    if [[ -z "$INFO" ]]; then
        sketchybar --set $NAME drawing=off
        return
    fi

    local -a info
    info=(${(f)"$(echo "$INFO" | jq -r '.["Player State"] + "\n" + .Name + "\n" + (if .Artist == "" then .Album else .Artist end)')"})

    local player_state=${info[1]}
    local title=${info[2]}   
    local second_line=${info[3]}

    if [[ -z "$title" ]]; then
        sketchybar --set $NAME drawing=off
        return
    fi

    local display_info="${title} - ${second_line}"
    if (( ${#display_info} > MAX_LENGTH )); then
      display_info="${display_info:0:$((MAX_LENGTH-1))}…"
    fi
    
    local icon="􀊖 "
    if [[ "$player_state" == "Paused" ]]; then
        icon="􀊘 "
    fi

    if [[ "$player_state" == "Playing" ]] || [[ "$player_state" == "Paused" ]]; then
        sketchybar --set $NAME drawing=on icon="$icon" label="$display_info"
    else
        sketchybar --set $NAME drawing=off
    fi
}

case "$SENDER" in
    "mouse.clicked")
        osascript -e 'tell application "Spotify" to playpause'
        ;;
    *)
        update_track
        ;;
esac
