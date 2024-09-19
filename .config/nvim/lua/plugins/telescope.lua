return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "benfowler/telescope-luasnip.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      require("telescope").load_extension("luasnip")
      require("telescope").load_extension("ui-select")

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>fl", function()
        vim.cmd([[Telescope luasnip]])
      end, {})
    end,
  },
}
