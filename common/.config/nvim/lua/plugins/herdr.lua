-- send code to an agent in this herdr workspace: your instruction plus
-- file:line (or the selection in a fenced block, with its diagnostics)
return {
	"jwarykowski/herdr.nvim",
	cmd = { "HerdrSend", "HerdrFocus" },
	keys = {
		{ "<leader>ai", "<cmd>HerdrSend<cr>", desc = "agent: ask about this line" },
		{ "<leader>ai", ":HerdrSend<cr>", mode = "x", desc = "agent: ask about selection" },
		{ "<leader>aI", "<cmd>HerdrSend!<cr>", desc = "agent: ask, picking the agent" },
		{ "<leader>af", "<cmd>HerdrFocus<cr>", desc = "agent: focus its pane" },
	},
	opts = {},
}
