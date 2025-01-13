return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",

  version = "*",
  opts = {
    -- https://cmp.saghen.dev/configuration/keymap.html#presets
    keymap = {
      preset = "enter",

      cmdline = {
        preset = "default",
      },
    },

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
