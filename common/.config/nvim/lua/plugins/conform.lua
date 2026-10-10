local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = { "ConformInfo", "FormatDisable", "FormatEnable" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				go = { "goimports", "gofmt", stop_after_first = true },
				rust = { "rustfmt" },
				css = prettier,
				cpp = { "clang_format" },
				c = { "clang_format" },
				html = prettier,
				javascript = prettier,
				json = prettier,
				jsonc = prettier,
				lua = { "stylua" },
				markdown = prettier,
				python = { "ruff_format" },
				sh = { "shfmt" },
				toml = { "taplo" },
				bash = { "shfmt" },
				typescript = prettier,
				typescriptreact = prettier,
				yaml = prettier,
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		})

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
