return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	keys = {
		{ "<leader>e", ":Neotree toggle reveal<CR>", silent = false, desc = "Folat File Explorer" },
	},
	config = function()
		require("neo-tree").setup({
			commands = {
				copy_selector = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local vals = {
						["BASENAME"] = modify(filename, ":r"),
						["EXTENSION"] = modify(filename, ":e"),
						["FILENAME"] = filename,
						["PATH (CWD)"] = modify(filepath, ":."),
						["PATH (HOME)"] = modify(filepath, ":~"),
						["PATH"] = filepath,
						["URI"] = vim.uri_from_fname(filepath),
					}

					local options = vim.tbl_filter(function(val)
						return vals[val] ~= ""
					end, vim.tbl_keys(vals))
					if vim.tbl_isempty(options) then
						vim.notify("No values to copy", vim.log.levels.WARN)
						return
					end
					table.sort(options)
					vim.ui.select(options, {
						prompt = "Choose to copy to clipboard:",
						format_item = function(item)
							return ("%s: %s"):format(item, vals[item])
						end,
					}, function(choice)
						local result = vals[choice]
						if result then
							vim.notify(("Copied: `%s`"):format(result))
							vim.fn.setreg("+", result)
						end
					end)
				end,
			},
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
				mappings = {
					Y = "copy_selector",
				},
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
				},
				window = {
					mappings = {
						["O"] = "open_in_finder",
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
			},
		})
	end,
}
