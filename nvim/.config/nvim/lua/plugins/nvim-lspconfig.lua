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
				"html",
				"jsonls",
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"ts_ls",
				"tailwindcss",
				"yamlls",
			},
			automatic_enable = false,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		lazy = false,
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- local function on_attach(client, bufnr) end

			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				lspconfig[server_name].setup({
					-- on_attach = on_attach,
					capabilities = capabilities,
				})
			end
		end,
		opts = function(_, opts)
			opts.diagnostics = {
				float = {
					border = "rounded",
				},
			}
		end,
	},
}
