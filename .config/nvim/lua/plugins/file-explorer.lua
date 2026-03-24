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
}
