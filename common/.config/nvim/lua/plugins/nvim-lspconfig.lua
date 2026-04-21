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
			local capabilities = require("blink.cmp").get_lsp_capabilities({
				textDocument = { completion = { completionItem = { snippetSupport = false } } },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local kmap = function(mode, keys, func, desc)
						vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. (desc or "") })
					end

					kmap("n", "gD", vim.lsp.buf.declaration, "go to declaration")
					kmap("n", "K", vim.lsp.buf.hover, "hover documentation")
					kmap("n", "<leader>k", vim.lsp.buf.signature_help, "signature help")
					kmap("i", "<C-s>", vim.lsp.buf.signature_help, "signature help")
					kmap("n", "grn", vim.lsp.buf.rename, "rename")
					kmap("n", "gra", vim.lsp.buf.code_action, "code action")
					kmap("n", "gO", vim.lsp.buf.document_symbol, "document symbol")
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

			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				-- if we haven't defined a custom config above, use the default
				if not vim.lsp.type_to_host or not vim.lsp.type_to_host[server_name] then
					vim.lsp.config(server_name, {
						capabilities = capabilities,
					})
				end
				vim.lsp.enable(server_name)
			end
		end,
	},
}
