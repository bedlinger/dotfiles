return {
	-- Base colors
	black = 0xff1d2021,
	white = 0xffebdbb2,
	red = 0xffcc241d,
	green = 0xff98971a,
	yellow = 0xffd79921,
	blue = 0xff458588,
	purple = 0xffb16286,
	aqua = 0xff689d6a,
	orange = 0xffd65d0e,
	gray = 0xff928374,
	transparent = 0x00000000,

	-- Muted variants
	muted_red = 0xff9d0006,
	muted_green = 0xff79740e,
	muted_yellow = 0xffb57614,
	muted_blue = 0xff076678,
	muted_purple = 0xff8f3f71,
	muted_aqua = 0xff427b58,
	muted_orange = 0xffaf3a03,

	-- Bright variants
	bright_red = 0xfffb4934,
	bright_green = 0xffb8bb26,
	bright_yellow = 0xfffabd2f,
	bright_blue = 0xff83a598,
	bright_purple = 0xffd3869b,
	bright_aqua = 0xff8ec07c,
	bright_orange = 0xfffe8019,

	-- Neutral
	bg0 = 0xff282828,
	bg1 = 0xff3c3836,
	bg2 = 0xff504945,
	bg3 = 0xff665c54,
	bg4 = 0xff7c6f64,
	fg0 = 0xfffbf1c7,
	fg1 = 0xffebdbb2,
	fg2 = 0xffd5c4a1,
	fg3 = 0xffbdae93,
	fg4 = 0xffa89984,

	-- Bar
	bar = {
		bg = 0x00000000,
		border = 0x00000000,
	},
	icon_color = 0xffebdbb2,
	label_color = 0xffebdbb2,
	shadow_color = 0xff1d2021,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return bit.bor(bit.band(color, 0x00ffffff), bit.lshift(math.floor(alpha * 255.0), 24))
	end,
}
