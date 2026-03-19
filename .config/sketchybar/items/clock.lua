local colors = require("colors")

local function getCurrentDateAndTime()
	return os.date("%a %x - %X")
end

local clock = sbar.add("item", {
	position = "right",
	label = getCurrentDateAndTime(),
	icon = "􀧞",
	background = {
		color = colors.muted_blue,
	},
	update_freq = 1,
})

clock:subscribe("routine", function(_)
	clock:set({
		label = getCurrentDateAndTime(),
	})
end)
