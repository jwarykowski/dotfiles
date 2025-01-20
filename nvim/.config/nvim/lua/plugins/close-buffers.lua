return {
	{
		"asheq/close-buffers.vim",
		config = function()
			vim.keymap.set("n", "<leader>Q", ":Bdelete menu<cr>")
		end,
	},
}
