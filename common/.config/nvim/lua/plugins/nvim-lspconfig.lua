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
				"bashls",
				"clangd",
				"cssls",
				"html",
				"jsonls",
				"lua_ls",
				"omnisharp_mono",
				"pyright",
				"rust_analyzer",
				"tailwindcss",
				"ts_ls",
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
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local kmap = function(mode, keys, func, desc)
						vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. (desc or "") })
					end

					kmap("n", "gD", vim.lsp.buf.declaration, "go to declaration")
					kmap("n", "<leader>k", vim.lsp.buf.signature_help, "signature help")
					kmap("i", "<C-s>", vim.lsp.buf.signature_help, "signature help")
					kmap("n", "gO", vim.lsp.buf.document_symbol, "document symbol")
					kmap("n", "<leader>ca", vim.lsp.buf.code_action, "code action")
					kmap("n", "gl", vim.diagnostic.open_float, "line diagnostics")
					-- standard diagnostics
					kmap("n", "<leader>dn", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "next diagnostic")

					kmap("n", "<leader>dp", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "previous diagnostic")
					-- error-specific jumping
					kmap("n", "<leader>en", function()
						vim.diagnostic.jump({
							count = 1,
							severity = vim.diagnostic.severity.ERROR,
							float = true,
						})
					end, "next error")
					kmap("n", "<leader>ep", function()
						vim.diagnostic.jump({
							count = -1,
							severity = vim.diagnostic.severity.ERROR,
							float = true,
						})
					end, "previous error")
				end,
			})

			-- clangd setup
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=never",
					"--query-driver=/usr/bin/clang++,/usr/bin/g++,/opt/homebrew/bin/*",
				},
			})
			vim.lsp.enable("clangd")

			-- sourcekit setup
			vim.lsp.config("sourcekit", {
				capabilities = capabilities,
				root_dir = function(bufnr)
					return vim.fs.root(bufnr, {
						"Package.swift",
						".git",
						"*.xcodeproj",
						"*.xcworkspace",
					})
				end,
			})
			vim.lsp.enable("sourcekit")

			-- omnisharp_mono setup
			vim.lsp.config("omnisharp_mono", {
				capabilities = capabilities,
				settings = {
					enable_editorconfig_support = true,
					enable_import_completion = true,
					enable_roslyn_analyzers = true,
					organize_imports_on_format = true,
				},
				root_dir = function(bufnr)
					return vim.fs.root(bufnr, { "*.sln", "*.csproj", ".git" })
				end,
			})
			vim.lsp.enable("omnisharp_mono")

			local custom_servers = { clangd = true, sourcekit = true, omnisharp_mono = true }
			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				if not custom_servers[server_name] then
					vim.lsp.config(server_name, { capabilities = capabilities })
				end
				vim.lsp.enable(server_name)
			end
		end,
	},
}
