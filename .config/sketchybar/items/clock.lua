local colors = require("colors")

local function get_current_date_and_time()
	return os.date("%a %d/%m/%y - %X")
end

local clock = sbar.add("item", {
	position = "right",
	label = get_current_date_and_time(),
	icon = "􀧞",
	background = {
		color = colors.muted_blue,
	},
	update_freq = 1,
})

clock:subscribe("routine", function(_)
	clock:set({
		label = get_current_date_and_time(),
	})
end)
