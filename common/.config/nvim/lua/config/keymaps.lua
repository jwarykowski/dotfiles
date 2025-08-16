local map = vim.keymap.set

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "next buffer" })
map("n", "<leader><tab>", "<cmd>e #<cr>", { desc = "switch to other buffer" })

-- clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })

-- clear search, diff update and redraw
map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "redraw / clear hlsearch / diff update" }
)

-- clipboard
map({ "n", "v", "x" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
map({ "n", "v", "x" }, "<leader>Y", '"+yy', { noremap = true, silent = true, desc = "Yank line to clipboard" })
map({ "n", "v", "x" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
map("n", "<leader>^", '<cmd>:let @+ = expand("%")<cr>', { noremap = true, silent = true, desc = "Yank buffer path" })

-- delete word backwards
map("n", "dw", "vb_d")

-- indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- move to window
map("n", "<C-h>", "<C-w>h", { desc = "move to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "move to right window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "go to top window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "go to bottom window", remap = true })

-- split window
map("n", "ss", ":split<Return>", { noremap = true, silent = true })
map("n", "sv", ":vsplit<Return>", { noremap = true, silent = true })
