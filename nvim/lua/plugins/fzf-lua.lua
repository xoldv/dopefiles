return {
	"ibhagwan/fzf-lua",
	opts = {},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				border = "none",
				fullscreen = true,
				title_pos = "left",
				treesitter = {
					enabled = true,
					fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" },
				},
			},
		})

		vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "FZF Files" })
		vim.keymap.set("n", "<leader>fw", fzf.live_grep, { desc = "FZF Live Grep" })
		vim.keymap.set("n", "<leader>fb", fzf.buffers, {})
		vim.keymap.set("n", "<leader>fh", fzf.help_tags, {})
		vim.keymap.set("n", "<leader>gb", fzf.git_branches, {})
		vim.keymap.set("n", "<leader>gc", fzf.git_commits, {})
		vim.keymap.set("n", "<leader>gs", fzf.git_status, {})
		vim.keymap.set("n", "<leader>ls", fzf.lsp_document_symbols, {})
	end,
}
