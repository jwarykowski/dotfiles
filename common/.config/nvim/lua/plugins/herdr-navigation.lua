return {
	"paulbkim-dev/vim-herdr-navigation",
	lazy = false,
	config = function()
		-- <C-h/j/k/l> cross vim splits, fall through to herdr panes at an edge.
		-- Falls back to tmux (if $TMUX set) or plain wincmd outside herdr.
		dofile(vim.fn.stdpath("data") .. "/lazy/vim-herdr-navigation/editor/nvim.lua")
	end,
}
