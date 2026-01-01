return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,

			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = false,
			},
			preview_config = nil,
			attach_to_untracked = false,
			on_attach = function(bufnr)
			end,
		})
	end,
}
