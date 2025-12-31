return {

	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				json = { "jsonlint" },
				lua = { "luacheck" },
				bash = { "shellharden" },
				toml = { "tombi" },
				yaml = { "yamllint" },
				c_sharp = { "ast_grep" },
				go = { "golangci_lint" },
			}

			lint.linters.golangci_lint = {
				name = "golangci-lint",
				cmd = "golangci-lint",
				stdin = true,
				args = {
					"run",
					"--out-format",
					"json",
					"--show-stats=false",
					"--print-issued-lines=false",
					"--print-linter-name=false",
				},
				ignore_exitcode = true,
				parser = require("lint.parser").from_errorformat("%f:%l:%c:%m", {
					source = "golangci-lint",
				}),
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					if not vim.bo.modifiable then
						return
					end

					local status, err = pcall(function()
						lint.try_lint()
					end)

					if not status then
						vim.defer_fn(function()
							print("Linter error: " .. err)
						end, 0)
					end
				end,
			})
		end,
	},
}
