return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
			},
			sync_install = true,
			auto_install = true,
			highlight = {
				enable = true,
			},
		},
	},
}
