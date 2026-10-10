return {
	{
		"nvim-mini/mini.snippets",
		version = false,
		config = function()
			local gen_loader = require("mini.snippets").gen_loader

			-- default_prepare resolves lang via treesitter, so tsx/bash keys
			-- cover typescriptreact/sh buffers; explicit ft keys are fallbacks
			local js = { "javascript.json", "react.json" }
			local tsx = { "typescriptreact.json", "react.json", "tsdoc.json" }
			local shell = { "shell.json", "shelldoc.json" }

			require("mini.snippets").setup({
				mappings = {
					stop = "<Esc>",
				},
				snippets = {
					gen_loader.from_lang({
						lang_patterns = {
							javascriptreact = js,
							jsx = js,
							typescript = { "typescript.json", "tsdoc.json" },
							typescriptreact = tsx,
							tsx = tsx,
							sh = shell,
							bash = shell,
							zsh = shell,
						},
					}),
				},
			})
		end,
	},
}
