vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

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
		local gs = package.loaded.gitsigns

		vim.keymap.set("n", "]g", function()
			if vim.wo.diff then
				return "]g"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr })

		vim.keymap.set("n", "[g", function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr })
	end,
})
