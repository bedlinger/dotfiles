local sbar = require("sketchybar")
local colors = require("colors")
local icons = require("icons")
local util = require("helpers.util")

local function get_battery_state()
	local percentage = tonumber(util.execute("pmset -g batt | grep -Eo '\\d+%' | cut -d% -f1"))
	local charging = util.execute("pmset -g batt | grep 'AC Power'") ~= ""
	local icon
	if charging then
		icon = icons.battery.charging
	elseif percentage >= 90 then
		icon = icons.battery.full
	elseif percentage >= 75 then
		icon = icons.battery.three_quarters
	elseif percentage >= 50 then
		icon = icons.battery.half
	elseif percentage >= 25 then
		icon = icons.battery.one_quarter
	elseif percentage >= 0 then
		icon = icons.battery.empty
	else
		icon = icons.error
	end
	return percentage, icon
end

local function get_airpods_batteries()
	local output = util.execute("system_profiler SPBluetoothDataType", true)
	local result = {}
	local current_device = nil
	for line in output:gmatch("[^\n]+") do
		local device = line:match("^          ([^%s][^:]+):%s*$")
		if device then
			current_device = device
		end
		if current_device then
			local case_pct = line:match("Case Battery Level: (%d+)")
			local left_pct = line:match("Left Battery Level: (%d+)")
			local right_pct = line:match("Right Battery Level: (%d+)")
			if case_pct or left_pct or right_pct then
				if not result[current_device] then
					result[current_device] = {}
				end
				if case_pct then
					result[current_device].case = tonumber(case_pct)
				end
				if left_pct then
					result[current_device].left = tonumber(left_pct)
				end
				if right_pct then
					result[current_device].right = tonumber(right_pct)
				end
			end
		end
	end
	return result
end

local function get_bluetooth_batteries()
	local output = util.execute("pmset -g accps", true)
	local airpods = get_airpods_batteries()
	local devices = {}
	for line in output:gmatch("[^\n]+") do
		local raw_name, percent = line:match("%-(.-)%s*%(id=%d+%)%s+(%d+)%%")
		if raw_name and percent then
			local name = raw_name:match("^%s*(.-)%s*$")
			local base_name = name:gsub(" Case$", "")
			if not name:find("InternalBattery") and not (name ~= base_name and airpods[base_name]) then
				local pct = tonumber(percent)
				local airpods_data = airpods[name]
				if airpods_data then
					if airpods_data.case then
						table.insert(devices, { name = name .. " (Case)", percent = airpods_data.case })
					end
					if airpods_data.left then
						table.insert(devices, { name = name .. " (Left)", percent = airpods_data.left })
					end
					if airpods_data.right then
						table.insert(devices, { name = name .. " (Right)", percent = airpods_data.right })
					end
				else
					table.insert(devices, { name = name, percent = pct })
				end
			end
		end
	end
	return devices
end

local function percent_icon(pct)
	if pct >= 90 then
		return icons.battery.full
	elseif pct >= 75 then
		return icons.battery.three_quarters
	elseif pct >= 50 then
		return icons.battery.half
	elseif pct >= 25 then
		return icons.battery.one_quarter
	else
		return icons.battery.empty
	end
end

local percentage, battery_icon = get_battery_state()
local battery = sbar.add("item", "battery", {
	position = "right",
	label = tostring(percentage) .. "%",
	icon = battery_icon,
	background = { color = colors.muted_yellow },
	update_freq = 30,
	popup = {
		align = "right",
		background = { border_color = colors.muted_yellow },
	},
})

local function toggle_battery_popup()
	sbar.exec("sketchybar --remove '/battery.device\\..*/'")

	local devices = get_bluetooth_batteries()
	for i, device in ipairs(devices) do
		sbar.add("item", "battery.device." .. i, {
			position = "popup.battery",
			icon = {
				string = percent_icon(device.percent),
				color = device.percent <= 20 and colors.red or colors.white,
			},
			label = {
				string = string.format("%-30s %d%%", device.name, device.percent),
				color = device.percent <= 20 and colors.red or colors.white,
			},
		})
	end

	battery:set({ popup = { drawing = "toggle" } })
end

battery:subscribe("mouse.clicked", function(_)
	toggle_battery_popup()
end)

battery:subscribe("mouse.exited.global", function(_)
	battery:set({ popup = { drawing = false } })
end)

local function update_battery()
	local pct, icon = get_battery_state()
	battery:set({
		label = tostring(pct) .. "%",
		icon = icon,
	})
end

battery:subscribe("power_source_change", function(_)
	update_battery()
end)
battery:subscribe("routine", function(_)
	update_battery()
end)
