vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

return {
  "stevearc/oil.nvim",
  opts = {
    delete_to_trash = true,
    show_hidden = false,
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
