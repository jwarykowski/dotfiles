return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "NeoTree",
  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      enable_diagnostics = true,
      enable_git_status = true,
      popup_border_style = "rounded",
      sort_case_insensitive = false,
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        use_libuv_file_watcher = true,
      },
      window = { width = 60 },
    })
  end,
  keys = {
    {
      "<leader>e",
      function()
        local reveal_file = vim.fn.expand("%:p")
        if reveal_file == "" then
          reveal_file = vim.fn.getcwd()
        else
          local f = io.open(reveal_file, "r")
          if f then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end
        require("neo-tree.command").execute({
          action = "focus",
          source = "filesystem",
          position = "left",
          reveal_file = reveal_file,
          reveal_force_cwd = true,
          toggle = true,
        })
      end,
      desc = "explore neotree (cwd)",
    },
  },
}
