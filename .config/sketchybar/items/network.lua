local colors = require("colors")
local icons = require("icons")
local util = require("helpers.util")

local NETWORK_STATE_FILE <const> = "/tmp/sketchybar_network_toggle_state"
local NETWORK_STATE_VALUES <const> = {
	SSID = "SSID",
	IP_ADDRESS = "IP_ADDRESS",
}

local function write_to_state_file(new_state)
	local network_state_file = io.open(NETWORK_STATE_FILE, "w+")

	if not network_state_file then
		return nil
	end

	network_state_file:write(new_state)

	network_state_file:close()
end

local function get_current_state()
	local network_state_file = io.open(NETWORK_STATE_FILE, "r")

	if not network_state_file then
		write_to_state_file(NETWORK_STATE_VALUES.IP_ADDRESS)
		return get_current_state()
	end

	local current_state = network_state_file:read("l")

	network_state_file:close()

	return current_state
end

local function get_ip_address()
	return util.execute("scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1")
end

local function get_ssid()
	return util.execute(
		"networksetup -listpreferredwirelessnetworks en0 | sed -n '2p' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'"
	)
end

local function is_connected_to_network()
	return tostring(get_ip_address()) ~= ""
end

local function get_current_label()
	return not is_connected_to_network() and "No Connection"
		or get_current_state() == NETWORK_STATE_VALUES.IP_ADDRESS and get_ip_address()
		or get_ssid()
end

local function get_current_icon()
	return not is_connected_to_network() and icons.network.not_connected or icons.network.connected
end

local network = sbar.add("item", {
	position = "right",
	label = get_current_label(),
	icon = get_current_icon(),
	background = {
		color = colors.muted_aqua,
	},
	update_freq = 10,
})

network:subscribe("mouse.clicked", function(_)
	local current_state = get_current_state()
	local new_state = current_state == NETWORK_STATE_VALUES.IP_ADDRESS and NETWORK_STATE_VALUES.SSID
		or NETWORK_STATE_VALUES.IP_ADDRESS
	write_to_state_file(new_state)

	network:set({
		label = get_current_label(),
		icon = get_current_icon(),
	})
end)

network:subscribe("routine", function(_)
	network:set({
		label = get_current_label(),
		icon = get_current_icon(),
	})
end)
