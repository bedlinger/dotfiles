return {
	{
		"nvim-mini/mini.files",
		version = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("mini.files").setup()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			view = {
				width = 33,
				relativenumber = true,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					show = {
						folder_arrow = true,
					},
				},
				group_empty = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		},
	},
}
