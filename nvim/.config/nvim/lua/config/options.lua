vim.cmd("set expandtab")
vim.cmd("set nowrap")
vim.cmd("set shiftwidth=2")
vim.cmd("set softtabstop=2")
vim.cmd("set tabstop=2")

vim.g.mapleader = ";"
vim.g.background = "dark"

vim.opt.foldcolumn = "0"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
--vim.opt.foldlevelstart = 1
vim.opt.foldmethod = "expr"
--vim.opt.foldnestmax = 4
vim.opt.foldtext = ""
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.swapfile = false

vim.diagnostic.config({
	float = {
		border = "rounded",
		source = true,
	},
	severity_sort = true,
	virtual_text = { current_line = true },
})

vim.o.winborder = "rounded"
