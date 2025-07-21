return {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	config = true,
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
