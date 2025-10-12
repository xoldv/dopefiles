return {
	"ibhagwan/fzf-lua",
	opts = {},
	config = function()
		local fzf = require("fzf-lua")

		local last_files_query = ""
		local last_grep_query = ""

		fzf.setup({
			winopts = {
				split = "belowright new",
				height = 0.8,
				width = 30,
				border = "rounded",
				fullscreen = false,
				title_pos = "left",
			},
			files = {
				fzf_opts = {
					["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
				},
			},
			grep = {
				fzf_opts = {
					["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
				},
			},
		})

		vim.keymap.set("n", "<leader>ff", function()
			fzf.files({
				query = last_files_query,
				actions = {
					["default"] = function(selected, opts)
						last_files_query = opts.query or ""
						require("fzf-lua.actions").file_edit_or_qf(selected, opts)
					end,
				},
			})
		end, { desc = "FZF Files" })

		vim.keymap.set("n", "<leader>fw", function()
			fzf.live_grep({
				query = last_grep_query,
				actions = {
					["default"] = function(selected, opts)
						last_grep_query = opts.query or ""
						require("fzf-lua.actions").file_edit_or_qf(selected, opts)
					end,
				},
			})
		end, { desc = "FZF Live Grep" })
	end,
}
