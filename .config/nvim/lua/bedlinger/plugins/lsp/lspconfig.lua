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
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local keymap = vim.keymap

			local opts = { noremap = true, silent = true }

			local on_attach = function(client, bufnr)
				opts.buffer = bufnr

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end

			local capabilities = cmp_nvim_lsp.default_capabilities()

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				virtual_text = true,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = true,
			})

			local lspGroup = vim.api.nvim_create_augroup("Lsp", { clear = true })

			vim.api.nvim_create_autocmd("CursorHold", {
				command = "lua vim.diagnostic.open_float()",
				group = lspGroup,
			})

			-- Configure LSP servers
			vim.lsp.config("*", {
				capabilities = capabilities,
				on_attach = on_attach,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})

			vim.lsp.config("cssls", {
				settings = {
					css = { validate = true, lint = {
						unknownAtRules = "ignore",
					} },
					scss = { validate = true, lint = {
						unknownAtRules = "ignore",
					} },
					less = { validate = true, lint = {
						unknownAtRules = "ignore",
					} },
				},
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
