return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>a", group = "agent" },
			{ "<leader>c", group = "code" },
			{ "<leader>d", group = "diagnostics" },
			{ "<leader>e", group = "errors" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>gh", group = "github" },
			{ "<leader>n", group = "test" },
			{ "<leader>q", group = "quit/session" },
			{ "<leader>s", group = "search" },
			{ "<leader>t", group = "shepherd" },
			{ "<leader>u", group = "toggles" },
			{ "<leader>x", group = "trouble" },
		},
	},
}
