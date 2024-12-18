return {

  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "benfowler/telescope-luasnip.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = require("telescope.themes").get_ivy({
          mappings = {
            i = {
              ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            },
          },
          path_display = { "truncate" },
          preview = {
            hide_on_startup = true,
          },
          theme = "ivy",
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        }),

        pickers = {
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ["<C-d>"] = require("telescope.actions").delete_buffer,
              },
            },
          },
          git_files = {
            show_untracked = true,
            use_git_root = false,
          },
          find_files = {
            hidden = true, -- dotfiles
            follow = true, -- symlinks
          },
        },

        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          fzf = {
            case_mode = "smart_case",
            fuzzy = true,
            override_file_sorter = true,
            override_generic_sorter = true,
          },
        },
      })

      require("telescope").load_extension("luasnip")
      require("telescope").load_extension("ui-select")

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>I", builtin.lsp_workspace_symbols)
      vim.keymap.set("n", "<leader>fb", builtin.buffers)
      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
      vim.keymap.set("n", "<leader>fh", builtin.help_tags)
      vim.keymap.set("n", "<leader>gb", builtin.git_bcommits)
      vim.keymap.set("n", "<leader>gc", builtin.git_commits)
      vim.keymap.set("n", "<leader>gf", builtin.git_files)
      vim.keymap.set("n", "<leader>i", builtin.lsp_document_symbols)
      vim.keymap.set("n", "<leader>r", builtin.lsp_references)
    end,
  },
}
