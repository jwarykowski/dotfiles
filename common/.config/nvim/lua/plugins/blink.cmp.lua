return {
	"saghen/blink.cmp",
	dependencies = "echasnovski/mini.snippets",
	version = "*",
	opts = {
		appearance = {
			use_nvim_cmp_as_default = true,
		},
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
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
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
