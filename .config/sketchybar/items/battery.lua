local colors = require("colors")
local util = require("helpers.util")

local function get_battery_percentage()
	return tonumber(util.execute("pmset -g batt | grep -Eo '\\d+%' | cut -d% -f1"))
end

local function is_battery_charging()
	return util.execute("pmset -g batt | grep 'AC Power'") ~= ""
end

local function getBatteryIcon()
	if is_battery_charging() then
		return "􀢋"
	elseif get_battery_percentage() >= 90 then
		return "􀛨"
	elseif get_battery_percentage() >= 75 then
		return "􀺸"
	elseif get_battery_percentage() >= 50 then
		return "􀺶"
	elseif get_battery_percentage() >= 25 then
		return "􀛩"
	elseif get_battery_percentage() >= 0 then
		return "􀛪"
	else
		return "404"
	end
end

local battery = sbar.add("item", {
	position = "right",
	label = tostring(get_battery_percentage()) .. "%",
	icon = getBatteryIcon(),
	background = { color = colors.muted_yellow },
	update_freq = 30,
})

battery:subscribe("power_source_change", function(_)
	battery:set({
		label = tostring(get_battery_percentage()) .. "%",
		icon = getBatteryIcon(),
	})
end)

battery:subscribe("routine", function(_)
	battery:set({
		label = tostring(get_battery_percentage()) .. "%",
		icon = getBatteryIcon(),
	})
end)
