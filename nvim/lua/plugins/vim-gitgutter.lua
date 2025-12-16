return {
	"airblade/vim-gitgutter",
	init = function()
		vim.g.gitgutter_diff_base = "HEAD"
		vim.g.gitgutter_sign_added = "│"
		vim.g.gitgutter_sign_modified = "│"
		vim.g.gitgutter_sign_removed = "_"
		vim.g.gitgutter_set_sign_backgrounds = 0
		vim.api.nvim_set_hl(0, "GitGutterAdd", { fg = "#4185a1" })
	end,
}
