return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				auto_install = true,
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"bash",
					"javascript",
					"typescript",
					"html",
					"css",
					"json",
					"python",
					"go",
					"rust",
					"markdown",
				},
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
