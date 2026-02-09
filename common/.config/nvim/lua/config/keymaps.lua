local map = vim.keymap.set

-- buffers
map("n", "<s-h>", "<cmd>bprevious<cr>", { desc = "buffer: previous" })
map("n", "<s-l>", "<cmd>bnext<cr>", { desc = "buffer: next" })
map("n", "<leader><tab>", "<cmd>e #<cr>", { desc = "buffer: switch to last" })

-- search & redraw
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear search highlights" })

-- clipboard
local clip_opts = { silent = true, desc = "clipboard: yank" }
map({ "n", "v", "x" }, "<leader>y", '"+y', clip_opts)
map({ "n", "v", "x" }, "<leader>y", '"+yy', { silent = true, desc = "clipboard: yank line" })
map({ "n", "v", "x" }, "<leader>p", '"+p', { silent = true, desc = "clipboard: paste" })
map("n", "<leader>^", '<cmd>let @+ = expand("%:p")<cr>', { silent = true, desc = "clipboard: copy full path" })

-- indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- window navigation
map("n", "<c-h>", "<c-w>h", { desc = "go to left window", remap = true })
map("n", "<c-j>", "<c-w>j", { desc = "go to bottom window", remap = true })
map("n", "<c-k>", "<c-w>k", { desc = "go to top window", remap = true })
map("n", "<c-l>", "<c-w>l", { desc = "go to right window", remap = true })

-- splits
map("n", "ss", "<cmd>split<cr>", { desc = "split horizontal" })
map("n", "sv", "<cmd>vsplit<cr>", { desc = "split vertical" })

-- quiting
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "quit all" })
map("n", "<leader>qw", "<cmd>wq<cr>", { desc = "save and quit" })
