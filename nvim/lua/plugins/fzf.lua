vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

local fzf = require("fzf-lua")

local function history(name)
	return {
		["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-" .. name .. "-history",
		["--bind"] = "start:last-history",
	}
end

fzf.setup({
	winopts = {
		split = "belowright new",
		preview = { layout = "flex" },
	},
	defaults = { formatter = "path.filename_first" },
	files = { fzf_opts = history("files") },
	grep = {
		fzf_opts = history("grep"),
		rg_opts = table.concat({
			"--hidden",
			"--follow",
			"--glob",
			'"!**/.git/*"',
			"--column",
			"--line-number",
			"--no-heading",
			"--color=always",
			"--smart-case",
			"--max-columns=4096",
			"-e",
		}, " "),
	},
	keymap = {
		fzf = {
			["ctrl-q"] = "select-all+accept",
		},
	},
})
fzf.register_ui_select()

vim.keymap.set("n", "<leader>ff", function()
	fzf.files({
		resume = true,
	})
end, { desc = "FZF Files" })

vim.keymap.set("n", "<leader>fw", function()
	fzf.live_grep({
		resume = true,
	})
end, { desc = "FZF Live Grep" })

vim.keymap.set("n", "<leader>fW", fzf.grep_curbuf, { desc = "FZF Grep Buffer" })
vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "FZF Resume" })
vim.keymap.set("n", "<leader>fo", fzf.oldfiles, { desc = "FZF Oldfiles" })
vim.keymap.set("n", "<leader>fd", fzf.diagnostics_workspace, { desc = "FZF Diagnostics" })
vim.keymap.set("n", "<leader>fg", fzf.git_status, { desc = "Find Git" })
vim.keymap.set("n", "<leader>fc", function()
	fzf.git_bcommits({ follow = true })
end, { desc = "Find Git Buffer Commits" })
vim.keymap.set("n", "<leader>fb", fzf.dap_breakpoints, { desc = "Find breakpoints" })
vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "Find helptags" })
vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "Find keymaps" })
