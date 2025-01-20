local keymap = function()
	vim.keymap.set("n", "<leader>Q", ":Bdelete menu<cr>")
end

return {
	{
		"asheq/close-buffers.vim",
		config = function()
			keymap()
		end,
	},
}
