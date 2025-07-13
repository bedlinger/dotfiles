return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				json = { "prettierd" },
				toml = { "taplo" },
				yaml = { "prettierd", "gh-actions-language-server" },
				xml = { "xmlformatter" },
				vue = { "prettierd" },
				markdown = { "prettierd" },
				nginx = { "nginx-config-formatter" },
				sql = { "sql-formatter" },
				c_sharp = { "csharpier" },
				rust = { "rustfmt" },
				python = { "ruff", "reorder-python-imports", "docformatter" },
				go = { "golines", "gomodifytags", "gofumpt", "goimports" },
				java = { "goole-java-format" },
				kotlin = { "ktfmt" },
				bash = { "beautysh" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>nv", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
