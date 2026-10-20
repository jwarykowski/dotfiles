-- statusline Focus / wpm (require("keybars").status() in mini.lua)
return {
	"jwarykowski/keybars.nvim",
	cmd = { "KeybarsRun", "KeybarsMarket", "KeybarsFocus", "KeybarsLight", "KeybarsClear" },
	keys = {
		{ "<leader>br", ":KeybarsRun ", desc = "keybars: run a command" },
		{ "<leader>bm", "<cmd>KeybarsMarket<cr>", desc = "keybars: marketplace" },
		{ "<leader>bf", "<cmd>KeybarsFocus<cr>", desc = "keybars: start Focus" },
	},
	opts = {},
}
