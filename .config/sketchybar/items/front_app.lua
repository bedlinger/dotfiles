local colors = require("colors")
local app_icons = require("helpers.app_icons")

local front_app_name = "404"
local front_app_icon = app_icons["Default"]

local front_app = sbar.add("item", {
	position = "left",
	display = "active",
	label = front_app_name,
	icon = {
		string = front_app_icon,
		font = "sketchybar-app-font:Regular:16.0",
	},
	background = {
		color = colors.bright_blue,
	},
})

front_app:subscribe("front_app_switched", function(env)
	front_app_name = env.INFO
	front_app_icon = app_icons[front_app_name]

	front_app:set({
		label = front_app_name,
		icon = front_app_icon,
	})
end)
