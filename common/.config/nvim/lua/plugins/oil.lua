vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

return {
	"stevearc/oil.nvim",
	opts = {
		columns = {
			"icon",
			"permissions",
			"size",
			"mtime",
		},
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
		},
	},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
}
