return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"typescript-language-server",
				"html-lsp",
				"css-lsp",
				"css-variables-language-server",
				"cssmodules-language-server",
				"tailwindcss-language-server",
				"json-lsp",
				"taplo", -- toml lsp
				"yaml-language-server",
				"gh-actions-language-server",
				"lemminx", -- xml lsp
				"vue-language-server",
				"astro-language-server",
				"marksman", -- md lsp
				"nginx-language-server",
				"dockerfile-language-server",
				"docker-compose-language-service",
				"sqls",
				"omnisharp",
				"rust-analyzer",
				"pyright",
				"gopls",
				"java-language-server",
				"kotlin-language-server",
				"bash-language-server",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"prettierd",
				"xmlformatter",
				"nginx-config-formatter",
				"sql-formatter",
				"csharpier",
				"rustfmt",
				"ruff",
				"reorder-python-imports",
				"docformatter",
				"golines",
				"gomodifytags",
				"gofumpt",
				"goimports",
				"google-java-format",
				"ktfmt",
				"beautysh",
				"luacheck",
				"eslint_d",
				"htmlhint",
				"stylelint",
				"jsonlint",
				"tombi", -- toml linter
				"yamllint",
				"actionlint",
				"markdownlint",
				"sqruff",
				"sonarlint-language-server",
				"bacon",
				"golangci-lint",
				"checkstyle",
				"ktlint",
				"shellcheck",
				"dotenv-linter",
			},
		})
	end,
}
