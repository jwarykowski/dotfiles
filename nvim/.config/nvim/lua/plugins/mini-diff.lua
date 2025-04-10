return {
	{
		"echasnovski/mini.diff",
		version = false,
		config = function()
			require("mini.diff").setup({
				view = {
					style = "number",
				},
			})
		end,
	},
}
