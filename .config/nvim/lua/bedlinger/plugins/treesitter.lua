---@diagnostic disable: missing-fields
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = "false",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"lua",
				"vim",
				"javascript",
				"typescript",
				"html",
				"css",
				"json",
				"toml",
				"yaml",
				"csv",
				"xml",
				"vue",
				"astro",
				"editorconfig",
				"markdown",
				"nginx",
				"dockerfile",
				"sql",
				"c_sharp",
				"rust",
				"python",
				"go",
				"gomod",
				"gosum",
				"java",
				"javadoc",
				"kotlin",
				"bash",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
