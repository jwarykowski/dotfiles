local map = vim.keymap.set

-- buffers
map("n", "<s-h>", "<cmd>bprevious<cr>", { desc = "buffer: previous" })
map("n", "<s-l>", "<cmd>bnext<cr>", { desc = "buffer: next" })
map("n", "<leader><tab>", "<cmd>e #<cr>", { desc = "buffer: switch to last" })

-- search & redraw
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear search highlights" })

-- clipboard
map({ "n", "v", "x" }, "<leader>y", '"+y', { silent = true, desc = "clipboard: yank" })
map("n", "<leader>Y", '"+y$', { silent = true, desc = "clipboard: yank to end of line" })
map({ "n", "v", "x" }, "<leader>p", '"+p', { silent = true, desc = "clipboard: paste" })
map("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<cr>', { silent = true, desc = "clipboard: copy path" })

-- indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- window navigation: handled by vim-herdr-navigation (<c-h/j/k/l> move between
-- vim splits and fall through to herdr panes at an edge). See plugins/herdr-navigation.lua.

-- splits
map("n", "ss", "<cmd>split<cr>", { desc = "split horizontal" })
map("n", "sv", "<cmd>vsplit<cr>", { desc = "split vertical" })

-- scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "scroll up centered" })

-- saving
map("n", "<leader>w", "<cmd>w<cr>", { desc = "save file" })

-- quiting
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "quit all" })
map("n", "<leader>qw", "<cmd>wq<cr>", { desc = "save and quit" })
