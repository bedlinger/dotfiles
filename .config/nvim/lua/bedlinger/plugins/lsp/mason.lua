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
				"ts_ls",
				"html",
				"cssls",
				"css_variables",
				"cssmodules_ls",
				"tailwindcss",
				"jsonls",
				"taplo", -- toml lsp
				"yamlls",
				"gh_actions_ls",
				"lemminx", -- xml lsp
				"vue_ls",
				"astro",
				"marksman", -- md lsp
				"nginx_language_server",
				"dockerls",
				"docker_compose_language_service",
				"sqls",
				"omnisharp",
				"rust_analyzer",
				"pyright",
				"gopls",
				"java_language_server",
				"kotlin_language_server",
				"bashls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"prettier",
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
				"eslint",
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
