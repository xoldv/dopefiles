return {
	"ibhagwan/fzf-lua",
	opts = {},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				split = "belowright new",
				height = 0.8,
				width = 30,
				border = "rounded",
				fullscreen = false,
				title_pos = "left",
				treesitter = {
					enabled = true,
					fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" },
				},
			},
			keymap = {
				fzf = {
					-- ["tab"] = "down",
					-- ["shift-tab"] = "up",
				},
			},
			preview = {
				hidden = true,
			},
			files = {
				actions = {
					["default"] = require("fzf-lua.actions").file_edit_or_qf,
				},
			},
			grep = {
				hidden = true,
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
