return {
	"saghen/blink.cmp",
	dependencies = "nvim-mini/mini.snippets",
	version = "*",
	opts = {
		-- https://cmp.saghen.dev/configuration/keymap.html#presets
		cmdline = {
			keymap = {
				preset = "default",
			},
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
			ghost_text = { enabled = true },
		},
		fuzzy = { implementation = "rust" },
		keymap = {
			preset = "enter",
		},
		snippets = { preset = "mini_snippets" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}
