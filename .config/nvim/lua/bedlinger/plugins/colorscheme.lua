return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
		})
		vim.api.nvim_create_autocmd("ColorScheme", {
			command = [[highlight DiagnosticUnderlineError gui=undercurl]],
			desc = "undercurl errors",
		})
		require("gruvbox").setup({
			transparent_mode = true,
			italic = {
				strings = false,
			},
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
