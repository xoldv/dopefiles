vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/mfussenegger/nvim-dap-python" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
	{ src = "https://github.com/igorlfs/nvim-dap-view" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	{ src = "https://github.com/Weissle/persistent-breakpoints.nvim" },
})

local dap = require("dap")
local dapview = require("dap-view")
local persistent_breakpoints = require("persistent-breakpoints.api")

dapview.setup()
require("dap-python").setup("/opt/homebrew/bin/python3")
require("dap-go").setup()
require("nvim-dap-virtual-text").setup()
require("persistent-breakpoints").setup({
	load_breakpoints_event = { "BufReadPost" },
})


dap.listeners.before.attach.dapui_config = dapview.open
dap.listeners.before.launch.dapui_config = dapview.open

vim.keymap.set("n", "<leader>bb", persistent_breakpoints.toggle_breakpoint)

vim.keymap.set("n", "<leader>bc", persistent_breakpoints.clear_all_breakpoints)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F6>", dap.restart)

vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
vim.keymap.set("n", "<leader>?", function()
	dapview.eval(nil, { enter = true })
end)
vim.keymap.set("n", "<leader>dq", function()
	dapview.close()
	dap.terminate()
end, { desc = "Close debugger" })
