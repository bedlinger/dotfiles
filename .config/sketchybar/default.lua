local settings = require("settings")
local colors = require("colors")

sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
		color = colors.icon_color,
		padding_left = 10,
		padding_right = 2,
		background = { image = { corner_radius = 9 } },
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = 16.0,
		},
		color = colors.label_color,
		padding_left = 5,
		padding_right = 10,
	},
	background = {
		height = 28,
		corner_radius = 5,
		border_width = 0,
	},
	popup = {
		background = {
			border_width = 2,
			corner_radius = 5,
			border_color = colors.bright_blue,
			color = colors.bg0,
			shadow = { drawing = true },
		},
	},
	padding_left = 5,
	padding_right = 5,
	scroll_texts = true,
})
