vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- let the LSP update imports when oil moves or renames files
vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(ev)
		for _, action in ipairs(ev.data.actions) do
			if action.type == "move" then
				Snacks.rename.on_rename_file(action.src_url:gsub("^oil://", ""), action.dest_url:gsub("^oil://", ""))
			end
		end
	end,
})

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
