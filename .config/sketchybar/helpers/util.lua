local function execute(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

local function get_display_count()
	return tonumber(execute("sketchybar --query displays | jq 'length'"))
end

local function split(str, sep)
	local result = {}
	for s in str:gmatch("[^" .. sep .. "]+") do
		table.insert(result, s)
	end
	return result
end

return { execute = execute, get_display_count = get_display_count, split = split }
