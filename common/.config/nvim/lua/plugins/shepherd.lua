return {
	"jwarykowski/nvim-shepherd",
	cmd = { "Shepherd", "ShepherdAdd" },
	keys = {
		{ "<leader>T", "<cmd>Shepherd<cr>", desc = "shepherd board" },
		{ "<leader>ta", "<cmd>ShepherdAdd<cr>", desc = "shepherd quick-add" },
	},
	opts = {
		-- board scoped to the repo you're in
		filter = function()
			return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		end,
	},
}
