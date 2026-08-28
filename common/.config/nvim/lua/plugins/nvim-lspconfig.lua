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
				"eslint",
				"gopls",
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
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		lazy = false,
		config = function()
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local kmap = function(mode, keys, func, desc)
						vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. (desc or "") })
					end

					kmap("n", "gD", vim.lsp.buf.declaration, "go to declaration")
					kmap("n", "<leader>k", vim.lsp.buf.signature_help, "signature help")
					kmap("n", "<leader>ca", vim.lsp.buf.code_action, "code action")
					kmap("n", "<leader>cr", vim.lsp.buf.rename, "rename symbol")
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
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=never",
					"--query-driver=/usr/bin/clang++,/usr/bin/g++,/opt/homebrew/bin/*",
				},
			})

			-- sourcekit setup (ships with Xcode, not mason-managed)
			vim.lsp.config("sourcekit", {
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
				settings = {
					FormattingOptions = {
						EnableEditorConfigSupport = true,
						OrganizeImports = true,
					},
					RoslynExtensionsOptions = {
						EnableAnalyzersSupport = true,
						EnableImportCompletion = true,
					},
				},
				root_dir = function(bufnr)
					return vim.fs.root(bufnr, { "*.sln", "*.csproj", ".git" })
				end,
			})
		end,
	},
}
