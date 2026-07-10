return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			-- main branch: setup() only takes install_dir; parsers install via
			-- install() and highlighting starts per-buffer via vim.treesitter.start().
			local ts = require("nvim-treesitter")
			local ensure = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"json",
				"python",
				"go",
				"rust",
				"markdown",
				"markdown_inline",
			}
			local have = ts.get_installed and ts.get_installed("parsers") or {}
			local missing = vim.tbl_filter(function(lang)
				return not vim.tbl_contains(have, lang)
			end, ensure)
			if #missing > 0 then
				ts.install(missing)
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					if vim.b[ev.buf].slow_file then
						return
					end
					pcall(vim.treesitter.start, ev.buf)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				multiline_threshold = 1,
			})
		end,
	},
}
