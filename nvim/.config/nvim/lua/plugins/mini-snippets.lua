return {
	{
		"echasnovski/mini.snippets",
		version = false,
		config = function()
			local gen_loader = require("mini.snippets").gen_loader

			require("mini.snippets").setup({
				snippets = {
					gen_loader.from_file("~/.config/nvim/snippets/css.json"),
					gen_loader.from_file("~/.config/nvim/snippets/global.json"),
					gen_loader.from_file("~/.config/nvim/snippets/html.json"),
					gen_loader.from_file("~/.config/nvim/snippets/javascript.json"),
					gen_loader.from_file("~/.config/nvim/snippets/markdown.json"),
					gen_loader.from_file("~/.config/nvim/snippets/react.json"),
					gen_loader.from_file("~/.config/nvim/snippets/shell.json"),
					gen_loader.from_file("~/.config/nvim/snippets/shelldoc.json"),
					gen_loader.from_file("~/.config/nvim/snippets/tsdoc.json"),
					gen_loader.from_file("~/.config/nvim/snippets/typescript.json"),
					gen_loader.from_file("~/.config/nvim/snippets/typescriptreact.json"),

					-- note: investigate why this doesn't work
					-- gen_loader.from_lang(),
				},
			})
		end,
	},
}
