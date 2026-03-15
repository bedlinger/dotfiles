return {
  {		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("gruvbox").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
				transparent_mode = true,
			})

			vim.cmd.colorscheme("gruvbox")
		end,
}
}
