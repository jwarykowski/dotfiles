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

-- delete word backwards
map("n", "dw", "vb_d")

-- indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- move up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- resize window
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "increase window width" })
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "decrease window width" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "decrease window height" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "increase window height" })

-- move to window
map("n", "<C-h>", "<C-w>h", { desc = "move to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "move to right window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "go to top window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "go to bottom window", remap = true })

-- select all
map("n", "<C-a>", "gg<S-v>G")

-- split window
map("n", "ss", ":split<Return>", { noremap = true, silent = true })
map("n", "sv", ":vsplit<Return>", { noremap = true, silent = true })
