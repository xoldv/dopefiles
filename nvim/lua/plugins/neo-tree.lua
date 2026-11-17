vim.pack.add({
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
})

-- directory nvim was started in, used by the "g." mapping
local start_dir = vim.fn.getcwd()
require("neo-tree").setup({
	popup_border_style = "single",
	-- no markers to the right of names except git status (needed for [g / ]g)
	enable_diagnostics = false,
	enable_modified_markers = false,

	window = {
		position = "float",
	},

	default_component_configs = {
		-- netrw-like tree: "| " guides, no expander arrows
		indent = {
			indent_size = 2,
			padding = 0,
			with_markers = true,
			indent_marker = "|",
			last_indent_marker = "|",
			with_expanders = false,
		},
		git_status = {
			symbols = {
				added = "+ ",
				untracked = "? ",
				unstaged = "! ",
			},
		},
		icon = { enabled = false },
		last_modified = { enabled = false },
	},

	filesystem = {
		components = {
			-- netrw-like names: directories end with "/", root is not bold
			name = function(config, node, state)
				local result = require("neo-tree.sources.common.components").name(config, node, state)
				if node.type == "directory" then
					if node:get_depth() > 1 then
						result.text = result.text .. "/"
					else
						result.highlight = "Comment"
					end
				end
				return result
			end,
		},
		commands = {
			reset_root = function(state)
				vim.cmd.cd(vim.fn.fnameescape(start_dir))
				require("neo-tree.sources.filesystem").navigate(state, start_dir)
			end,
			open_in_finder = function(state)
				local node = state.tree:get_node()
				local path = node.path
				if vim.fn.isdirectory(path) == 0 then
					path = vim.fn.fnamemodify(path, ":h")
				end
				vim.fn.jobstart({ "open", path }, { detach = true })
			end,
			-- over write default 'delete' command to 'trash'.
			delete = function(state)
				local inputs = require("neo-tree.ui.inputs")
				local path = state.tree:get_node().path
				local msg = "Are you sure you want to trash " .. path
				inputs.confirm(msg, function(confirmed)
					if not confirmed then
						return
					end

					vim.fn.system({ "trash", path })
					require("neo-tree.sources.manager").refresh(state.name)
				end)
			end,

			-- over write default 'delete_visual' command to 'trash' x n.
			delete_visual = function(state, selected_nodes)
				local inputs = require("neo-tree.ui.inputs")

				-- get table items count
				function GetTableLen(tbl)
					local len = 0
					for n in pairs(tbl) do
						len = len + 1
					end
					return len
				end

				local count = GetTableLen(selected_nodes)
				local msg = "Are you sure you want to trash " .. count .. " files ?"
				inputs.confirm(msg, function(confirmed)
					if not confirmed then
						return
					end
					for _, node in ipairs(selected_nodes) do
						vim.fn.system({ "trash", node.path })
					end
					require("neo-tree.sources.manager").refresh(state.name)
				end)
			end,
		},
		window = {
			mappings = {
				["O"] = "open_in_finder",
				["g."] = "reset_root",
			},
		},
		use_libuv_file_watcher = true,
		hijack_netrw_behavior = "open_current",
		group_empty_dirs = true,
		scan_mode = "deep", -- needed so empty dir chains are grouped before expanding
		filtered_items = {
			show_hidden_count = false,
			hide_by_name = { "node_modules" },
			never_show = { ".DS_Store" },
		},
	},

	source_selector = {
		winbar = false,
		sources = {
			{ source = "filesystem", display_name = "Files" },
		},
	},
})

-- reveal the current file only if it is inside cwd; never prompt to change cwd
vim.keymap.set("n", "<leader>e", function()
	vim.cmd("Neotree toggle reveal dir=" .. vim.fn.fnameescape(vim.fn.getcwd()))
end, { silent = true, desc = "Toggle file explorer (neo-tree)" })
