return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
				transparent_mode = true,
			})
			vim.cmd.colorscheme("gruvbox")
		end,
	},
}
