local colors = require("colors")
local icons = require("icons")
local util = require("helpers.util")

local Machine = {}
Machine.__index = Machine

function Machine.new(ip, name, os, status)
	local is_self = status == "-"
	return setmetatable({
		ip = ip,
		name = name,
		os = os,
		is_this_machine = is_self,
		is_active = is_self or status:find("active") ~= nil,
		offers_exit_node = status:find("offers exit node") ~= nil,
		last_seen = status:match("last seen (.-)%s*$"),
	}, Machine)
end

function Machine:is_online()
	return self.is_active or self.is_this_machine
end

function Machine:__tostring()
	return string.format(
		"ip=%-18s name=%-20s os=%-10s active=%-6s exit_node=%-6s last_seen=%s",
		self.ip,
		self.name,
		self.os,
		tostring(self.is_active),
		tostring(self.offers_exit_node),
		tostring(self.last_seen)
	)
end

local function parse_machine(line)
	local ip, name, _, os, status = line:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s*(.*)")
	if not ip then
		return nil
	end
	status = status:match("^%s*(.-)%s*$")
	return Machine.new(ip, name, os, status)
end

local function get_tailscale_status()
	local output = util.execute("/usr/local/bin/tailscale status", true)
	local machines = {}
	for line in output:gmatch("[^\n]+") do
		if line:match("%S") then
			local machine = parse_machine(line)
			if machine then
				table.insert(machines, machine)
			end
		end
	end
	return machines
end

local function is_tailscale_connected()
	return util.execute("/usr/local/bin/tailscale status", true):find("stopped") == nil
end

local function disconnect_from_tailscale()
	util.execute("/usr/local/bin/tailscale down")
end

local function connect_to_tailscale()
	util.execute("/usr/local/bin/tailscale up")
end

local tailscale = sbar.add("item", "tailscale", {
	position = "right",
	display = "active",
	label = { drawing = false },
	icon = {
		string = icons.tailscale,
		padding_right = 5,
		padding_left = 6,
		font = "sketchybar-app-font:Regular:16.0",
	},
	update_freq = 10,
})

local function set_tailscale_state()
	tailscale:set({
		background = {
			color = is_tailscale_connected() and colors.bg2 or colors.bright_red,
		},
	})
end

set_tailscale_state()

tailscale:subscribe("routine", set_tailscale_state)

tailscale:subscribe("mouse.clicked", function(_)
	if is_tailscale_connected() then
		disconnect_from_tailscale()
	else
		connect_to_tailscale()
	end

	set_tailscale_state()
end)
