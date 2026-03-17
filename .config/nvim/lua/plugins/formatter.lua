return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				bash = { "beautysh" },
				zsh = { "beautysh" },
				c_sharp = { "csharpier" },
				go = { "gofumpt" },
				java = { "google-java-format" },
				kotlin = { "ktfmt" },
				pyhon = { "ruff" },
				html = { "prettier" },
				css = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				astro = { "prettier" },
				vue = { "prettier" },
				sql = { "sqlfmt" },
				nginx = { "nginx-config-formatter" },
				markdown = { "mdformat" },
				json = { "prettier" },
				toml = { "tombi" },
				xml = { "xmlformatter" },
			},
		},
	},
}
