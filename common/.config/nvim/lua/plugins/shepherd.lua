return {
	"jwarykowski/nvim-shepherd",
	lazy = false, -- on rtp at startup so :checkhealth shepherd is discoverable
	keys = {
		{ "<leader>T", "<cmd>Shepherd<cr>", desc = "shepherd board" },
		{ "<leader>tg", "<cmd>Shepherd!<cr>", desc = "shepherd global view (all boards)" },
		{ "<leader>ta", "<cmd>ShepherdAdd<cr>", desc = "shepherd quick-add" },
		{ "<leader>tl", "<cmd>ShepherdList<cr>", desc = "shepherd list / pick" },
		{ "<leader>tc", "<cmd>ShepherdCapture<cr>", desc = "shepherd capture line" },
		{ "<leader>tc", ":ShepherdCapture<cr>", mode = "x", desc = "shepherd capture selection" },
		{ "<leader>ts", "<cmd>ShepherdStats<cr>", desc = "shepherd stats" },
		{ "<leader>tS", "<cmd>ShepherdStats!<cr>", desc = "shepherd stats (all boards)" },
		{ "<leader>tb", "<cmd>ShepherdBoards<cr>", desc = "shepherd boards" },
		{ "<leader>tB", "<cmd>ShepherdBoardsArchived<cr>", desc = "shepherd archived boards" },
	},
	opts = {
		-- per-repo board (own file under ~/.config/shepherd/boards/)
		board = function()
			return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		end,
	},
}
