vim.pack.add({
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
})

local mini_icons = require("mini.icons")
mini_icons.setup()
require("neo-tree").setup({
	window = {
		position = "float",
	},

	default_component_configs = {
		indent = {
			with_markers = true,
			with_expanders = true,
		},
		git_status = {
			symbols = {
				added = "+ ",
				untracked = "? ",
				unstaged = "! ",
				conflict = " ",
			},
		},
		icon = {
			provider = function(icon, node) -- setup a custom icon provider
				local text, hl
				if node.type == "file" then -- if it's a file, set the text/hl
					text, hl = mini_icons.get("file", node.name)
				elseif node.type == "directory" then -- get directory icons
					text, hl = mini_icons.get("directory", node.name)
					-- only set the icon text if it is not expanded
					if node:is_expanded() then
						text = nil
					end
				end

				-- set the icon text/highlight only if it exists
				if text then
					icon.text = text
				end
				if hl then
					icon.highlight = hl
				end
			end,
		},
		kind_icon = {
			provider = function(icon, node)
				icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
			end,
		},
	},

	filesystem = {
		commands = {
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

					vim.fn.system({ "trash", vim.fn.fnameescape(path) })
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
						vim.fn.system({ "trash", vim.fn.fnameescape(node.path) })
					end
					require("neo-tree.sources.manager").refresh(state.name)
				end)
			end,
		},
		window = {
			mappings = {
				["O"] = "open_in_finder",
			},
		},
		use_libuv_file_watcher = true,
		hijack_netrw_behavior = "open_current",
		hide_by_name = { "node_modules" },
		never_show = { ".DS_Store" },
	},

	source_selector = {
		winbar = true,
		sources = {
			{ source = "filesystem", display_name = "Files" },
		},
	},
})

vim.keymap.set("n", "<leader>e", ":Neotree toggle reveal<CR>", { silent = true })
