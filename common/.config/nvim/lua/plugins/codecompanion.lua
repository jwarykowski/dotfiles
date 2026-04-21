return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	},
	keys = {
		{ "<leader>aC", "<cmd>CodeCompanionChat Add<cr>", mode = { "n", "v" }, desc = "AI Chat Toggle" },
		{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat Toggle" },
		{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
		{ "<leader>ae", "<cmd>CodeCompanion /explain<cr>", mode = "v", desc = "AI Explain Code" },
		{ "<leader>ai", "mz:CodeCompanion ", mode = "n", desc = "AI Inline Prompt" },
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = { adapter = "gemini_cli" },
				inline = { adapter = "gemini_cli" },
				agent = { adapter = "gemini_cli" },
			},
			adapters = {
				gemini_cli = function()
					return require("codecompanion.adapters").extend("gemini_cli", {
						defaults = {
							auth_method = "gemini-api-key",
							model = "gemini-2.5-flash",
						},
						env = {
							GEMINI_API_KEY = "cmd: gpg --batch --quiet --decrypt ~/.config/ai/tokens/gemini-token.gpg",
						},
					})
				end,
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-sonnet-4-5",
							},
						},
					})
				end,
			},
			display = {
				chat = {
					show_token_count = true,
					show_timestamps = true,
					window_border = "rounded",
				},
				inline = {
					show_spinner = true,
				},
				action_palette = {
					provider = "snacks",
				},
			},
			prompt_library = {
				markdown = {
					dirs = {
						vim.fn.getcwd() .. "/.prompts",
						"~/.config/ai/prompts",
					},
				},
			},
		})
	end,
}
