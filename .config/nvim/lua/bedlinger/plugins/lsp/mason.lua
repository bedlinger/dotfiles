return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
		},

		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")

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
				automatic_installation = true,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			local installer = require("mason-tool-installer")
			installer.setup({
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
				run_on_start = true,
				vim.api.nvim_create_autocmd("User", {
					pattern = "MasonToolsStartingInstall",
					callback = function()
						vim.schedule(function()
							print("mason-tool-installer is starting")
						end)
					end,
				}),
			})
		end,
	},
}
