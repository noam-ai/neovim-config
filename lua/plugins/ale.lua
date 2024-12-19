return {
	{
		"dense-analysis/ale",
		config = function()
			-- Configuration goes here.
			local g = vim.g

			-- Only enables the linters that are explicitly set
			g.ale_linters_explicit = 1

			-- Configure ALE
			g.ale_linters = {
				python = { "ruff", "pyright" },
				sql = { "sqlfluff" },
				go = { "golsp" },
				c = { "clang" },
				typescript = { "eslint" },
				typescriptreact = { "eslint" },
				javascript = { "eslint" },
				javascriptreact = { "eslint" },
			}

			g.ale_javascript_eslint_executable = "eslint_d"

			-- Create a new sql fixer
			local function sqlfluff_fix()
				return {
					command = "sqlfluff fix --force --config ~/shape/monorepo/configs/.sqlfluff -",
				}
			end

			g.ale_fixers = {
				python = { "ruff" },
				json = { "jq" },
				sql = { sqlfluff_fix },
				go = { "gofmt", "goimports" },
				c = { "clang-format" },
				typescript = { "eslint" },
				typescriptreact = { "eslint" },
				javascript = { "eslint" },
				javascriptreact = { "eslint" },
				lua = { "stylua" },
			}

			g.ale_sql_sqlfluff_options = "--dialect postgres --config ~/shape/monorepo/configs/.sqlfluff"
			g.ale_fix_on_save = 1
		end,
	},
	{
		"rhysd/vim-lsp-ale",
		config = function()
			local g = vim.g
			-- Enable LSP linting
			g.lsp_ale_auto_enable_linter = 1
			g.lsp_ale_diagnostics_severity = "hint"
		end,
	},
}
