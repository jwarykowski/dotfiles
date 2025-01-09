return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",

  version = "*",
  opts = {
    keymap = { preset = "enter" },

    appearance = {
      use_nvim_cmp_as_default = true,
      -- nerd_font_variant = 'mono'
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
