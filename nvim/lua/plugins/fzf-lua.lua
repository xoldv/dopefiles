return {
	"ibhagwan/fzf-lua",
	opts = {},
	config = function()
		local fzf = require("fzf-lua")

		local last_files_query = ""
		local last_grep_query = ""
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
				cmd = table.concat(grep_opts, " "),
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
				rg_opts = "--hidden --no-ignore --no-ignore-vcs --column --line-number --no-heading --color=always --smart-case -- ''",
				actions = {
					["default"] = function(selected, opts)
						last_grep_query = opts.query or ""
						require("fzf-lua.actions").file_edit_or_qf(selected, opts)
					end,
				},
			})
		end, { desc = "FZF Live Grep" })
		vim.keymap.set("n", "<leader>fiu", '<cmd>lua require("fzf-lua").lsp_references()<cr>', { desc = "Find Usages" })
		vim.keymap.set("n", "<leader>fg", '<cmd>lua require("fzf-lua").git_status()<cr>', { desc = "Find Git" })
	end,
}
