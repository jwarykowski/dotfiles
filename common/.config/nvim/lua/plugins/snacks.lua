return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		---@type snacks.picker.Config
		picker = {
			enabled = true,
			layout = {
				preset = "ivy",
			},
		},
		notifier = { enabled = true, style = "minimal" },
	},
	keys = {
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep({ hidden = true })
			end,
			desc = "grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "command history",
		},
		{
			"<leader><space>",
			function()
				Snacks.picker.files()
			end,
			desc = "find files",
		},
		-- find
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "buffers",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "find config file",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files({ hidden = true })
			end,
			desc = "find git files",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "recent",
		},
		-- git
		{
			"<leader>gc",
			function()
				Snacks.picker.git_log()
			end,
			desc = "git commit log",
		},
		{
			"<leader>gfc",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "git file commit log",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "git status",
		},
		-- Grep
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "buffer lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "grep open buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "registers",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "autocmds",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "comamand history",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "commands",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "diagnostics",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "help pages",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "highlights",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "jumps",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "keymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "location list",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "man pages",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "marks",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "resume",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "quickfix list",
		},
		{
			"<leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "colour schemes",
		},
		{
			"<leader>qp",
			function()
				Snacks.picker.projects()
			end,
			desc = "projects",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "goto definition",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "references",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "goto implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "goto t[y]pe Definition",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "lsp symbols",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.pickers()
			end,
			desc = "snack pickers",
		},
	},
}
