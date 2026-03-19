local colors = require("colors")
local util = require("helpers.util")

local function getBatteryPercentage()
	return tonumber(util.execute("pmset -g batt | grep -Eo '\\d+%' | cut -d% -f1"))
end

local function isBatteryCharging()
	return util.execute("pmset -g batt | grep 'AC Power'") ~= ""
end

local function getBatteryIcon()
	if isBatteryCharging() then
		return "􀢋"
	elseif getBatteryPercentage() >= 90 then
		return "􀛨"
	elseif getBatteryPercentage() >= 75 then
		return "􀺸"
	elseif getBatteryPercentage() >= 50 then
		return "􀺶"
	elseif getBatteryPercentage() >= 25 then
		return "􀛩"
	elseif getBatteryPercentage() >= 0 then
		return "􀛪"
	else
		return "404"
	end
end

local battery = sbar.add("item", {
	position = "right",
	label = tostring(getBatteryPercentage()) .. "%",
	icon = getBatteryIcon(),
	background = { color = colors.muted_yellow },
	update_freq = 60,
})

battery:subscribe("power_source_change", function(_)
	battery:set({
		label = tostring(getBatteryPercentage()) .. "%",
		icon = getBatteryIcon(),
	})
end)
