vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

local oil = require("oil")
local start_dir = vim.fn.getcwd()
local hidden_names = { node_modules = true, __pycache__ = true }

---@param dir string
local function set_root(dir)
	vim.cmd.cd(vim.fn.fnameescape(dir))
	oil.open(dir)
end

oil.setup({
	delete_to_trash = true,
	view_options = {
		is_hidden_file = function(name)
			return name:match("^%.") ~= nil or hidden_names[name] == true
		end,
	},
	keymaps = {
		["."] = {
			desc = "Set directory as root and cwd",
			mode = "n",
			callback = function()
				local entry = oil.get_cursor_entry()
				local dir = oil.get_current_dir()
				if not dir then
					return
				end
				if entry and entry.type == "directory" then
					set_root(dir .. entry.name)
				else
					-- on a file: make the directory being browsed the cwd
					vim.cmd.cd(vim.fn.fnameescape(dir))
				end
			end,
		},
		["<BS>"] = { "actions.parent", mode = "n" },
		["gh"] = { "actions.toggle_hidden", mode = "n" },
		["g."] = {
			desc = "Reset root and cwd to start directory",
			mode = "n",
			callback = function()
				set_root(start_dir)
			end,
		},
		-- keep window navigation working inside oil buffers
		["<C-h>"] = false,
		["<C-l>"] = false,
	},
})

vim.keymap.set("n", "<leader>e", function()
	-- `:Oil` inside an oil buffer opens the parent directory, so toggle instead
	if vim.bo.filetype == "oil" then
		oil.close()
	else
		oil.open()
	end
end, { desc = "Toggle file explorer (oil)" })
