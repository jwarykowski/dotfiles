return {
	{
		"nvim-mini/mini.ai",
		version = false,
		event = "VeryLazy",
		-- provides the textobjects.scm queries gen_spec.treesitter reads
		dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" } },
		config = function()
			local ai = require("mini.ai")
			ai.setup({
				custom_textobjects = {
					-- f becomes function definition (default was function call)
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
				},
			})
		end,
	},
	{
		"nvim-mini/mini.diff",
		version = false,
		event = "VeryLazy",
		keys = {
			{
				"<leader>go",
				function()
					require("mini.diff").toggle_overlay(0)
				end,
				desc = "git diff overlay",
			},
		},
		config = function()
			require("mini.diff").setup()
		end,
	},
	{
		"nvim-mini/mini.indentscope",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.indentscope").setup()
		end,
	},
	{
		"nvim-mini/mini.operators",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.operators").setup({ replace = { prefix = "gR" } })
		end,
	},
	{
		"nvim-mini/mini.pairs",
		version = false,
		event = "InsertEnter",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"nvim-mini/mini.statusline",
		version = false,
		config = function()
			local MiniStatusline = require("mini.statusline")
			MiniStatusline.setup({
				content = {
					-- default active content plus a shepherd todo-count section
					active = function()
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
						local git = MiniStatusline.section_git({ trunc_width = 40 })
						local diff = MiniStatusline.section_diff({ trunc_width = 75 })
						local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
						local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
						local filename = MiniStatusline.section_filename({ trunc_width = 140 })
						local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
						local location = MiniStatusline.section_location({ trunc_width = 75 })
						local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
						local shepherd = require("shepherd").status()
						local kbd = require("config.kbd").status()

						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
							"%<",
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=",
							{ hl = "MiniStatuslineDevinfo", strings = { kbd, shepherd } },
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = mode_hl, strings = { search, location } },
						})
					end,
				},
			})
			require("config.kbd").start()
			-- counts load async; redraw when they arrive
			vim.api.nvim_create_autocmd("User", {
				pattern = "ShepherdStatusUpdate",
				callback = function()
					vim.cmd.redrawstatus()
				end,
			})
		end,
	},
	{
		"nvim-mini/mini.surround",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup()
		end,
	},
}
