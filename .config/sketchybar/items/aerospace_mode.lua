local settings = require("settings")

local aerospace_mode = sbar.add("item", {
	position = "left",
	label = { string = "[M]", font = { style = settings.font.style_map["Bold"], size = 18 } },
	icon = { drawing = false },
})

local function update_aerospace_mode(env)
	local new_mode = env.AEROSPACE_NEW_MODE

	if new_mode == "main" then
		aerospace_mode:set({ label = "[M]" })
	elseif new_mode == "service" then
		aerospace_mode:set({ label = "[S]" })
	elseif new_mode == "application" then
		aerospace_mode:set({ label = "[A]" })
	else
		aerospace_mode:set({ label = "[404]" })
	end
end

sbar.add("event", "aerospace_mode_change")

aerospace_mode:subscribe("aerospace_mode_change", update_aerospace_mode)
