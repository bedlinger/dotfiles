return {
	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = {}, -- tree-sitter CLI must be installed system-wide
		config = function()
			require("tree-sitter-manager").setup({
				ensure_installed = {
					"lua",
					"bash",
					"c_sharp",
					"razor",
					"go",
					"gomod",
					"gosum",
					"java",
					"javadoc",
					"kotlin",
					"python",
					"rust",
					"html",
					"css",
					"javascript",
					"typescript",
					"astro",
					"vue",
					"nginx",
					-- "robots",
					"dockerfile",
					"editorconfig",
					"gitignore",
					"git_config",
					"markdown",
					"json",
					"toml",
					"xml",
					"csv",
					"yaml",
				},
				auto_install = false,
			})
		end,
	},
}
