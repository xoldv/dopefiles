return {
	{
		"echasnovski/mini.ai",
		version = false,
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"nvim-mini/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
}
