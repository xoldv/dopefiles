return {
	{
		"tpope/vim-fugitive",
		lazy = false,
		config = function()
			local function toggle_git_blame()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")

					if buf_ft == "fugitiveblame" then
						vim.api.nvim_win_close(win, false)
						return
					end
				end

				vim.cmd("Git blame")
			end

			vim.keymap.set("n", "ga", toggle_git_blame, { desc = "Toggle git blame" })
		end,
	},
}
