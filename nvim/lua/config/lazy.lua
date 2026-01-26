-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup mapleader before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },

		{
			"breakpoints-bridge",
			dir = "~/code/breakpoints-bridge.nvim",
			config = function()
				local opts = {
					load_breakpoints_event = "BufReadPost", -- или "BufWinEnter"
					always_reload = true,
					autoload_before_dap_start = true,
				}
				local breakpoints_bridge = require("breakpoints-bridge")
				breakpoints_bridge.setup(opts)
				vim.keymap.set("n", "<leader>bb", breakpoints_bridge.toggle_breakpoint)
				vim.keymap.set("n", "<leader>br", breakpoints_bridge.reload_breakpoints)
				vim.keymap.set("n", "<leader>bc", breakpoints_bridge.clear_all_breakpoints)

				local neotest = require("neotest")
				vim.keymap.set("n", "<leader>td", function()
					breakpoints_bridge.run_with_actual_breakpoints(function()
						neotest.run.run({ strategy = "dap" })
					end)
				end, { desc = "Run nearest test in debug" })

				vim.keymap.set("n", "<leader>tD", function()
					breakpoints_bridge.run_with_actual_breakpoints(function()
						neotest.run.run({ file = vim.fn.expand("%"), strategy = "dap" })
					end)
				end, { desc = "Run current test file in debug" })

				vim.keymap.set("n", "<F6>", function()
					breakpoints_bridge.run_with_actual_breakpoints(function()
						require("dap").restart()
					end)
				end)
			end,
		},
	},
	defaults = { lazy = false },
	change_detection = { enabled = false },
})
