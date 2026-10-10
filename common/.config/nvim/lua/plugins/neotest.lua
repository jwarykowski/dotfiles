-- run jest through whichever package manager the project's lockfile names
local function jest_command()
	local root = vim.fn.getcwd()
	local runners = {
		{ "pnpm-lock.yaml", "pnpm test --" },
		{ "bun.lock", "bun run test --" },
		{ "bun.lockb", "bun run test --" },
		{ "yarn.lock", "yarn test" },
	}
	for _, runner in ipairs(runners) do
		if vim.uv.fs_stat(root .. "/" .. runner[1]) then
			return runner[2]
		end
	end
	return "npm test --"
end

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
		"nvim-neotest/neotest-jest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-vitest"),
				require("neotest-jest")({
					jestCommand = jest_command,
					env = { CI = true },
					cwd = vim.fn.getcwd,
				}),
			},
		})
	end,
	keys = {
		{
			"<leader>nr",
			"<cmd>lua require('neotest').run.run()<cr>",
			desc = "Run nearest test",
		},
		{
			"<leader>nf",
			"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
			desc = "Run current file",
		},
		{
			"<leader>na",
			"<cmd>lua require('neotest').run.run({ suite = true })<cr>",
			desc = "Run all tests",
		},
		{
			"<leader>ns",
			"<cmd>lua require('neotest').run.stop()<cr>",
			desc = "Stop test",
		},
		{
			"<leader>nn",
			"<cmd>lua require('neotest').run.attach()<cr>",
			desc = "Attach to nearest test",
		},
		{
			"<leader>no",
			"<cmd>lua require('neotest').output.open()<cr>",
			desc = "Show test output",
		},
		{
			"<leader>np",
			"<cmd>lua require('neotest').output_panel.toggle()<cr>",
			desc = "Toggle output panel",
		},
		{
			"<leader>nv",
			"<cmd>lua require('neotest').summary.toggle()<cr>",
			desc = "Toggle summary",
		},
		{
			"<leader>nc",
			"<cmd>lua require('neotest').run.run({ suite = true, env = { CI = true } })<cr>",
			desc = "Run all tests with CI",
		},
	},
}
