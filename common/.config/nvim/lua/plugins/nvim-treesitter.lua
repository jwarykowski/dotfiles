return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup()

		local ensure_installed = {
			"bash",
			"javascript",
			"typescript",
			"html",
			"css",
			"json",
			"python",
			"go",
			"rust",
		}

		local installed = ts.get_available()

		local missing = vim.tbl_filter(function(parser)
			return not vim.tbl_contains(installed, parser)
		end, ensure_installed)

		if #missing > 0 then
			ts.install(missing)
		end
	end,
}
