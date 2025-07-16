return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			lua = { "luacheck" },
			javascript = { "eslint_d", "eslint" },
			typescript = { "eslint_d", "eslint" },
			vue = { "eslint_d", "eslint" },
			astro = { "eslint_d", "eslint" },
			html = { "htmlhint" },
			css = { "stylelint" },
			json = { "jsonlint" },
			toml = { "tombi" },
			yaml = { "yamllint", "actionlint" },
			markdown = { "markdownlint" },
			sql = { "sqruff" },
			c_sharp = { "sonarlint-language-server" },
			rust = { "bacon" },
			python = { "ruff" },
			go = { "golangci-lint" },
			java = { "checkstyle" },
			kotlin = { "ktlint" },
			bash = { "shellcheck" },
			dotenv = { "dotenv-linter" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
