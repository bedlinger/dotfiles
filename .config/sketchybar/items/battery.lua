local colors = require("colors")
local icons = require("icons")
local util = require("helpers.util")

local function get_battery_percentage()
	return tonumber(util.execute("pmset -g batt | grep -Eo '\\d+%' | cut -d% -f1"))
end

local function is_battery_charging()
	return util.execute("pmset -g batt | grep 'AC Power'") ~= ""
end

local function get_battery_icon()
	if is_battery_charging() then
		return icons.battery.charging
	elseif get_battery_percentage() >= 90 then
		return icons.battery.full
	elseif get_battery_percentage() >= 75 then
		return icons.battery.three_quarters
	elseif get_battery_percentage() >= 50 then
		return icons.battery.half
	elseif get_battery_percentage() >= 25 then
		return icons.battery.one_quarter
	elseif get_battery_percentage() >= 0 then
		return icons.battery.empty
	else
		return icons.error
	end
end

local battery = sbar.add("item", {
	position = "right",
	label = tostring(get_battery_percentage()) .. "%",
	icon = get_battery_icon(),
	background = { color = colors.muted_yellow },
	update_freq = 30,
})

battery:subscribe("power_source_change", function(_)
	battery:set({
		label = tostring(get_battery_percentage()) .. "%",
		icon = get_battery_icon(),
	})
end)

battery:subscribe("routine", function(_)
	battery:set({
		label = tostring(get_battery_percentage()) .. "%",
		icon = get_battery_icon(),
	})
end)
