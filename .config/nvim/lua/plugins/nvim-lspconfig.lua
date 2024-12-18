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

      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
        ["sourcekit"] = function()
          lspconfig.sourcekit.setup({
            capabilities = {
              workspace = {
                didChangeWatchedFiles = {
                  dynamicRegistration = true,
                },
              },
            },
          })
        end,
      })
    end,
  },
}
