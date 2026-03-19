local colors = require("colors")
local util = require("helpers.util")

local percentage = tonumber(util.execute("pmset -g batt | grep -Eo '\\d+%' | cut -d% -f1"))
local isCharging = util.execute("pmset -g batt | grep 'AC Power'") ~= ""

local battery_icon = "404"
if percentage >= 90 then
	battery_icon = "􀛨"
elseif percentage >= 75 then
	battery_icon = "􀺸"
elseif percentage >= 50 then
	battery_icon = "􀺶"
elseif percentage >= 25 then
	battery_icon = "􀛩"
else
	battery_icon = "􀛪"
end

if isCharging then
	battery_icon = "􀢋"
end

local battery = sbar.add("item", {
	position = "right",
	label = {
		string = tostring(percentage) .. "%",
	},
	icon = battery_icon,
	background = { color = colors.muted_yellow },
	update_freq = 60,
})
