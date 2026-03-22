local colors = require("colors")
local icons = require("icons")
local util = require("helpers.util")

local function is_bluetooth_device_connected()
	return util.execute("blueutil --connected") ~= ""
end

local function get_bluetooth_icon()
	return is_bluetooth_device_connected() and icons.bluetooth.connected or icons.bluetooth.not_connected
end

local bluetooth = sbar.add("item", "bluetooth", {
	position = "right",
	display = "active",
	label = { drawing = false },
	icon = {
		string = get_bluetooth_icon(),
		padding_right = 5,
		padding_left = 5,
	},
	background = { color = colors.blue },
	popup = {
		align = "right",
		background = { border_color = colors.blue },
	},
	update_freq = 10,
})

local function toggle_bluetooth_popup()
	sbar.exec("sketchybar --remove '/bluetooth.device\\..*/'")

	local all_devices_raw = util.execute(
		"system_profiler SPBluetoothDataType | grep '^        .*:$' | sed 's/^[[:space:]]*//;s/:$//'",
		true
	)
	local connected_devices_raw = util.execute(
		"system_profiler SPBluetoothDataType | awk '/Connected:/{f=1} /Not Connected:|Devices \\(/{f=0} f && /^        .*:$/ {gsub(/^[ \\t]+|:$/, \"\"); print}'",
		true
	)

	local connected_devices = {}
	for device in connected_devices_raw:gmatch("[^\n]+") do
		if device:match("%S") then
			connected_devices[device] = true
		end
	end

	local counter = 0
	for device in all_devices_raw:gmatch("[^\n]+") do
		if device:match("%S") then
			local item_name = "bluetooth.device." .. counter
			local is_device_connected = connected_devices[device] == true
			local label_color = is_device_connected and colors.white or colors.gray

			local click_cmd = is_device_connected
					and string.format(
						'blueutil --disconnect "%s"; sketchybar --set bluetooth popup.drawing=off',
						device
					)
				or string.format('blueutil --connect "%s"; sketchybar --set bluetooth popup.drawing=off', device)

			sbar.add("item", item_name, {
				position = "popup.bluetooth",
				label = {
					string = device,
					color = label_color,
				},
				click_script = click_cmd,
			})

			counter = counter + 1
		end
	end

	bluetooth:set({ popup = { drawing = "toggle" } })
end

bluetooth:subscribe("mouse.clicked", function(_)
	toggle_bluetooth_popup()
end)

bluetooth:subscribe("mouse.exited.global", function(_)
	bluetooth:set({ popup = { drawing = false } })
end)

bluetooth:subscribe("routine", function(_)
	bluetooth:set({
		icon = get_bluetooth_icon(),
	})
end)
