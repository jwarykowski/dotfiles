-- open file picker on startup when no file given
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		if vim.fn.argc() == 0 then
			vim.schedule(function()
				Snacks.picker.files({
					hidden = true,
					layout = {
						fullscreen = true,
						hidden = { "preview" },
					},
				})
			end)
		end
	end,
})

-- trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- disable heavy features for large files
vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function(ev)
		local ok, stats = pcall(vim.uv.fs_stat, ev.match)
		if ok and stats and stats.size > 1024 * 500 then
			vim.b.slow_file = true
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.spell = false
			vim.treesitter.stop(ev.buf)
		end
	end,
})
