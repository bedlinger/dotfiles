return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			local capabilities = require("blink-cmp").get_lsp_capabilities()

			local vue_language_server_path = vim.fn.expand("$MASON/packages")
				.. "/vue-language-server"
				.. "/node_modules/@vue/language-server"

			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})
		end,
	},
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		dependencies = {
			{
				"stevearc/dressing.nvim",
				opts = {},
			},
		},
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"bashls",
				"csharp_ls",
				"gopls",
				"java_language_server",
				"kotlin_language_server",
				"pylsp",
				"html",
				"cssls",
				"css_variables",
				"tailwindcss",
				"ts_ls",
				"astro",
				"vue_ls",
				"sqls",
				"nginx_language_server",
				"docker_language_server",
				"marksman",
				"jsonls",
				"tombi",
				"lemminx",
				"yamlls",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"beautysh",
				"csharpier",
				"gofumpt",
				"google-java-format",
				"ktfmt",
				"ruff",
				"prettier",
				"sqlfmt",
				"nginx-config-formatter",
				"mdformat",
				"xmlformatter",
				"yamlfmt",
			},
			auto_update = true,
			integrations = {
				["mason-lspconfig"] = true,
				["mason-null-ls"] = false,
				["mason-nvim-dap"] = false,
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
}
