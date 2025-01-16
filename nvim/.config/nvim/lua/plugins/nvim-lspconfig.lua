return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "cssls",
        "denols",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "ts_ls",
        "tailwindcss",
        "yamlls",
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
        ["denols"] = function()
          lspconfig.denols.setup({
            on_attach = on_attach,
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
          })
        end,
        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            on_attach = on_attach,
            root_dir = lspconfig.util.root_pattern("package.json"),
            single_file_support = false,
          })
        end,
      })
    end,
  },
}
