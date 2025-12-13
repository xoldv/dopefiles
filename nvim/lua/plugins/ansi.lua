return {
	"0xferrous/ansi.nvim",
	config = function()
		require("ansi").setup({
			auto_enable = true, -- Auto-enable for configured filetypes
			filetypes = { "log", "ansi", 'dap-repl' }, -- Filetypes to auto-enable
		})
	end,
}
