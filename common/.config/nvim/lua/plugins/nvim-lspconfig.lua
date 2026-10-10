-- nearest dir holding a file whose name matches one of the lua patterns,
-- tried in order (vim.fs.root only matches exact names, not globs)
local function root_by_pattern(bufnr, patterns)
	for _, pattern in ipairs(patterns) do
		local root = vim.fs.root(bufnr, function(name)
			return name:match(pattern) ~= nil
		end)
		if root then
			return root
		end
	end
	return vim.fs.root(bufnr, ".git")
end

local lsp_events = { "BufReadPre", "BufNewFile" }

return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		event = lsp_events,
		config = function()
			require("mason").setup()
		end,
	},
	{
		-- formatters/linters, so every machine gets the same toolchain
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = "VeryLazy",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = { "goimports", "prettierd", "shfmt", "stylua", "taplo" },
				run_on_start = false,
			})
			require("mason-tool-installer").check_install(false)
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		event = lsp_events,
		opts = {
			-- omnisharp_mono needs mono, only installed on mac
			automatic_enable = { exclude = vim.fn.has("mac") == 1 and {} or { "omnisharp_mono" } },
			ensure_installed = {
				"bashls",
				"clangd",
				"cssls",
				"eslint",
				"gopls",
				"html",
				"jsonls",
				"lua_ls",
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
		event = lsp_events,
		config = function()
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					-- large files (see config/autocmds.lua) get no LSP
					if vim.b[bufnr].slow_file then
						vim.schedule(function()
							vim.lsp.buf_detach_client(bufnr, args.data.client_id)
						end)
						return
					end
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
				root_dir = function(bufnr, on_dir)
					on_dir(root_by_pattern(bufnr, { "^Package%.swift$", "%.xcworkspace$", "%.xcodeproj$" }))
				end,
			})
			if vim.fn.has("mac") == 1 then
				vim.lsp.enable("sourcekit")
			end

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
				root_dir = function(bufnr, on_dir)
					on_dir(root_by_pattern(bufnr, { "%.sln$", "%.csproj$" }))
				end,
			})
		end,
	},
}
