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
				"omnisharp",
				"pyright",
				"rust_analyzer",
				"stylua",
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

					kmap("n", "gd", vim.lsp.buf.definition, "go to definition")
					kmap("n", "grr", vim.lsp.buf.references, "references")
					kmap("n", "gD", vim.lsp.buf.declaration, "go to declaration")
					kmap("n", "gri", vim.lsp.buf.implementation, "go to implementation")
					kmap("n", "K", vim.lsp.buf.hover, "hover documentation")
					kmap("n", "<leader>k", vim.lsp.buf.signature_help, "signature help")
					kmap("i", "<C-s>", vim.lsp.buf.signature_help, "signature help")
					kmap("n", "grn", vim.lsp.buf.rename, "rename")
					kmap("n", "gra", vim.lsp.buf.code_action, "code action")
					kmap("n", "gO", vim.lsp.buf.document_symbol, "document symbol")
					kmap("n", "gl", vim.diagnostic.open_float, "line diagnostics")
					kmap("n", "<leader>dn", vim.diagnostic.goto_next, "next diagnostic")
					kmap("n", "<leader>dp", vim.diagnostic.goto_prev, "previous diagnostic")
					kmap("n", "<leader>en", function()
						vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.ERROR } })
					end, "next error")
					kmap("n", "<leader>ep", function()
						vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.ERROR } })
					end, "previous error")
				end,
			})

			vim.lsp.config("omnisharp", {
				cmd = { vim.fn.expand("~/.local/share/nvim/mason/packages/omnisharp/omnisharp") },
				capabilities = capabilities,
				settings = {
					enable_roslyn_analyzers = true,
					enable_editorconfig_support = true,
					enable_import_completion = true,
					organize_imports_on_format = true,
					sdk_include_prereleases = true,
					analyze_open_documents_only = false,
				},
				root_dir = function(bufnr)
					return vim.fs.root(bufnr, { "*.sln", "*.csproj", ".git" })
				end,
			})

			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				if server_name ~= "omnisharp" then
					vim.lsp.config(server_name, {
						capabilities = capabilities,
					})
				end
				vim.lsp.enable(server_name)
			end
		end,
		opts = {
			diagnostics = {
				float = { border = "rounded" },
				severity_sort = true,
				update_in_insert = false,
			},
		},
	},
}
