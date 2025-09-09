return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	keys = {
		{ "<leader>e", ":Neotree toggle left<CR>", silent = true, desc = "Float File Explorer" },
		-- { "<leader><Tab>", ":Neotree toggle left<CR>", silent = true, desc = "Left File Explorer" },
		{ "<leader><Tab>", ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "single",
			enable_git_status = true,
			enable_modified_markers = true,
			enable_diagnostics = true,
			sort_case_insensitive = true,
			tabs_max_width = 30,
			default_component_configs = {

				indent = {
					with_markers = true,
					with_expanders = true,
				},
				modified = {
					symbol = " ",
					highlight = "NeoTreeModified",
				},
				icon = {
					folder_closed = " ",
					folder_open = " ",
					folder_empty = " ",
					folder_empty_open = " ",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "+ ",
						-- deleted = " ",
						-- modified = " ",
						-- Status type
						untracked = "? ",
						unstaged = "! ",
						staged = "+ ",
						conflict = " ",
					},
				},
			},
			window = {
				position = "float",
				-- width = 25,
			},
			filesystem = {
				commands = {
					open_in_finder = function(state)
						local node = state.tree:get_node()
						local path = node.path

						-- Если это файл, открываем родительскую директорию
						if vim.fn.isdirectory(path) == 0 then
							path = vim.fn.fnamemodify(path, ":h") -- Получаем родительскую директорию
						end

						vim.fn.jobstart({ "open", path }, { detach = true })
					end,
					fzf_live_grep = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						require("fzf-lua").live_grep({ cwd = path })
					end,
				},
				window = {
					mappings = {
						["O"] = "open_in_finder", -- Добавляем клавишу O для открытия Finder
						["Z"] = "fzf_live_grep", -- Search with fzf
					},
				},
				use_libuv_file_watcher = true,
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_current",
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = {
					"node_modules",
				},
				never_show = {
					".DS_Store",
					"thumbs.db",
				},
			},
			source_selector = {
				winbar = true,
				sources = {
					{ source = "filesystem", display_name = "Files" },
					{ source = "git_status", display_name = " Git " },
				},
			},
			event_handlers = {
				{
					event = "neo_tree_window_after_open",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},
				{
					event = "neo_tree_window_after_close",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},
				-- {
				--   event = "file_open_requested",
				--   handler = function()
				--     -- auto close
				--     -- vim.cmd("Neotree close")
				--     -- OR
				--     require("neo-tree.command").execute({ action = "close" })
				--   end
				-- },
			},
		})
		local toggle_state = false

		vim.keymap.set("n", "<leader>lg", function()
			toggle_state = not toggle_state
			if toggle_state then
				vim.cmd("Neotree toggle left git_status")
			else
				vim.cmd("Neotree toggle left filesystem")
			end
		end, { desc = "Toggle Neo-tree git/files" })
	end,
}
