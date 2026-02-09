-- global settings
vim.g.mapleader = ";"
vim.g.background = "dark"

local opt = vim.opt

-- undo file configuration
local undo_path = vim.fn.stdpath("state") .. "/undo"
if not vim.uv.fs_stat(undo_path) then
	vim.fn.mkdir(undo_path, "p")
end

opt.expandtab = true -- use spaces instead of tabs
opt.wrap = false -- replaces opt.nowrap = true
opt.shiftwidth = 2 -- size of an indent
opt.softtabstop = 2 -- number of spaces tabs count for
opt.tabstop = 2 -- number of spaces tabs count for

-- ui / behavior
opt.relativenumber = true -- relative line numbers
opt.showmode = false -- don't show mode (already in statusline)
opt.splitright = true -- vertical splits to the right
opt.swapfile = false -- no swap files
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- smart case searching
opt.inccommand = "split" -- preview incremental substitute in a split
opt.winborder = "rounded" -- set borders for windows

-- folding (treesitter native)
opt.foldcolumn = "0"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "" -- keep fold line clean
opt.foldlevel = 99 -- start with all folds open
opt.foldlevelstart = 99

-- undo
vim.opt.undofile = true
vim.opt.undodir = undo_path

-- diagnostics configuration
vim.diagnostic.config({
	float = {
		border = "rounded",
		source = true,
	},
	severity_sort = true,
	virtual_text = { spacing = 4, prefix = "●", source = "if_many" },
})

-- disable heavy features for large files
vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function(ev)
		local ok, stats = pcall(vim.uv.fs_stat, ev.match)
		if ok and stats and stats.size > 1024 * 500 then -- 500 kb limit
			vim.b.slow_file = true
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.spell = false
		end
	end,
})
