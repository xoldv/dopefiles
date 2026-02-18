vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

local fzf = require("fzf-lua")
local grep_opts = {
	"rg",
	"--vimgrep",
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
}
fzf.setup({
	winopts = {
		split = "belowright new",
		height = 0.8,
		width = 30,
		-- border = "rounded",
		fullscreen = false,
		title_pos = "left",
	},
	files = {
		fzf_opts = {
			["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
			["--bind"] = "start:last-history",
		},
	},
	grep = {
		fzf_opts = {
			["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
			["--bind"] = "start:last-history",
		},
		cmd = table.concat(grep_opts, " "),
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
		rg_opts = "--hidden --no-ignore --no-ignore-vcs --column --line-number --no-heading --color=always --smart-case -- ''",
	})
end, { desc = "FZF Live Grep" })

vim.keymap.set("n", "<leader>fg", fzf.git_status, { desc = "Find Git" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "Find helptags" })
