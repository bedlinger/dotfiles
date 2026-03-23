local colors = require("colors")
local icons = require("icons")
local util = require("helpers.util")

sbar.add("event", "aerospace_workspace_change")

local function add_workspace_items_to_display(display, workspaces)
	for _, wid in ipairs(workspaces) do
		local click_cmd = "aerospace workspace " .. wid

		local workspace = sbar.add("item", "workspace." .. wid, {
			position = "left",
			display = display,
			label = wid,
			background = {
				height = 28,
			},
			click_script = click_cmd,
			updates = true,
		})

		workspace:subscribe("aerospace_workspace_change", function(env)
			local is_focused = wid == env.AEROSPACE_FOCUSED_WORKSPACE
			local is_occupied = util.execute('aerospace list-windows --workspace "' .. wid .. '"') ~= ""

			workspace:set({
				drawing = is_occupied or is_focused,
				icon = is_occupied and icons.workspace.occupied
					or is_focused and not is_occupied and icons.workspace.focused,
				background = {
					color = is_occupied and not is_focused and colors.muted_orange
						or is_focused and colors.bright_orange,
				},
			})
		end)
	end
end

if util.get_display_count() > 1 then
	add_workspace_items_to_display(1, util.split(util.execute("aerospace list-workspaces --monitor 2", true), "\n")) -- main display
	add_workspace_items_to_display(2, util.split(util.execute("aerospace list-workspaces --monitor 1", true), "\n")) -- secondary display

	sbar.add("bracket", { "/^workspace\\.[1-7]$/", "/^workspace\\.[8-9]$/" }, {
		background = {
			color = colors.bg0,
			height = 18,
		},
	})
else
	add_workspace_items_to_display(1, util.split(util.execute("aerospace list-workspaces --all", true), "\n"))

	sbar.add("bracket", { "/^workspace\\..*/" }, {
		background = {
			color = colors.bg0,
			height = 18,
		},
	})
end

sbar.trigger("aerospace_workspace_change", {
	AEROSPACE_FOCUSED_WORKSPACE = util.execute("aerospace list-workspaces --focused"),
})
