local colors = require("colors")
local icons = require("icons")
local util = require("helpers.util")

local audio = sbar.add("item", "audio", {
	position = "right",
	background = {
		color = colors.muted_purple,
	},
	popup = {
		align = "right",
		background = {
			border_color = colors.muted_purple,
		},
	},
})

local function toggle_audio_popup()
	if util.execute("which SwitchAudioSource") == "" then
		return
	end

	sbar.exec("sketchybar --remove '/audio.device\\..*/'")

	local current_device = util.execute("SwitchAudioSource -t output -c")
	local all_devices_raw = util.execute("SwitchAudioSource -a -t output", true)

	local counter = 0
	for device in all_devices_raw:gmatch("[^\n]+") do
		if device:match("%S") then
			local item_name = "audio.device." .. counter
			local is_current = device == current_device
			local label_color = is_current and colors.white or colors.gray

			local click_cmd = string.format(
				"SwitchAudioSource -s \"%s\" && sketchybar --set '/audio.device\\..*/' label.color=%s --set %s label.color=%s --set audio popup.drawing=off",
				device,
				colors.gray,
				item_name,
				colors.white
			)

			sbar.add("item", item_name, {
				position = "popup.audio",
				label = {
					string = device,
					color = label_color,
				},
				click_script = click_cmd,
			})

			counter = counter + 1
		end
	end

	audio:set({ popup = { drawing = "toggle" } })
end

audio:subscribe("mouse.clicked", function(_)
	toggle_audio_popup()
end)

audio:subscribe("mouse.exited.global", function(_)
	audio:set({ popup = { drawing = false } })
end)
audio:subscribe("volume_change", function(env)
	local volume = tonumber(env.INFO)
	local volume_icon = icons.volume.muted

	if volume >= 90 then
		volume_icon = icons.volume.loud
	elseif volume >= 50 then
		volume_icon = icons.volume.mid
	elseif volume > 0 then
		volume_icon = icons.volume.quiet
	end

	audio:set({
		label = volume .. "%",
		icon = volume_icon,
	})
end)
