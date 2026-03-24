local colors = require("colors")
local icons = require("icons")
local util = require("helpers.util")

local function is_spotify_running()
	return util.execute([[osascript << 'END'
if application "Spotify" is running then
  return "true"
end if
return "false"
END]]) == "true"
end

local function is_spotify_playing()
	if is_spotify_running() then
		local is_playing = util.execute("osascript -e 'tell application \"Spotify\" to get player state'")
		return tostring(is_playing) == "playing"
	end

	return false
end

local function get_spotify_current_track()
	if is_spotify_running() then
		return util.execute("osascript -e 'tell application \"Spotify\" to get name of current track'")
	end

	return nil
end

local function get_spotify_current_artist()
	if is_spotify_running() then
		return util.execute("osascript -e 'tell application \"Spotify\" to get artist of current track'")
	end

	return nil
end

local function toggle_spotify_play_state()
	if is_spotify_running() then
		util.execute("osascript -e 'tell application \"Spotify\" to playpause'")
	end
end

local spotify = sbar.add("item", {
	position = "center",
	display = 1,
	background = {
		color = colors.bg0,
	},
	updates = true,
})

local function set_spotify_state()
	local spotify_label = is_spotify_running() and get_spotify_current_track()

	if is_spotify_running() and tostring(get_spotify_current_artist()) ~= "" then
		spotify_label = spotify_label .. " - " .. get_spotify_current_artist()
	end

	spotify:set({
		drawing = util.get_display_count() > 1 and is_spotify_running(),
		label = spotify_label,
		icon = is_spotify_running() and is_spotify_playing() and icons.spotify.playing or icons.spotify.paused,
	})
end

sbar.add("event", "spotify_state_change", "com.spotify.client.PlaybackStateChanged")

spotify:subscribe("spotify_state_change", function(_)
	util.execute("sleep 0.5")
	set_spotify_state()
end)

-- spotify:subscribe("routine", set_spotify_state)

spotify:subscribe("mouse.clicked", function(_)
	toggle_spotify_play_state()
end)

set_spotify_state()
