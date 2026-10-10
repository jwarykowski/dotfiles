vim.loader.enable()

vim.opt.shada = {
	"!",
	"'50",
	"<50",
	"s10",
	"h",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("config.options")

require("lazy").setup("plugins", {
	ui = { border = "rounded" },
	change_detection = { notify = false },
	performance = {
		rtp = {
			-- netrw: oil replaces it
			disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
		},
	},
})

require("config.keymaps")
require("config.autocmds")
