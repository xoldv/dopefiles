return {
	"ibhagwan/fzf-lua",
	opts = {
		oldfiles = {
			include_current_session = true,
		},
		previewers = {
			builtin = {
				syntax_limit_b = 1024 * 100, -- 100KB
			},
		},
	},
	config = function()
		local fzf = require("fzf-lua")
		local fzf_actions = require("fzf-lua.actions")

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
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		})
		fzf.register_ui_select()

		vim.keymap.set("n", "<leader>ff", function()
			fzf.files({
				query = last_files_query,
				opts = {
					["--bind"] = "start:clear-query",
				},
				actions = {
					["default"] = function(selected, opts)
						last_files_query = opts.query or ""
						fzf_actions.file_edit_or_qf(selected, opts)
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
						fzf_actions.file_edit_or_qf(selected, opts)
					end,
				},
			})
		end, { desc = "FZF Live Grep" })
		vim.keymap.set("n", "<leader>fiu", fzf.lsp_references, { desc = "Find Usages" })
		vim.keymap.set("n", "<leader>fg", fzf.git_status, { desc = "Find Git" })
		vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find Buffers" })
		vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "Find Buffers" })
	end,
}
