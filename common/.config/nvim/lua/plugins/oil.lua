vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", function() require("oil").open(vim.fn.getcwd()) end, { desc = "File explorer (cwd)" })

return {
	"stevearc/oil.nvim",
	opts = {
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
		},
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
