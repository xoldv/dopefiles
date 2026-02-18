vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/mfussenegger/nvim-dap-python" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	{ src = vim.fn.expand("~/code/breakpoints-bridge.nvim") },
})

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

local function close_debugger()
	dapui.close()
	dap.terminate()
end

require("dap-python").setup("/opt/homebrew/bin/python3")
require("nvim-dap-virtual-text").setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end

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

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)

vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
vim.keymap.set("n", "<leader>?", function()
	dapui.eval(nil, { enter = true })
end)
vim.keymap.set("n", "<leader>dq", close_debugger, { desc = "Close DAP UI and terminate debug session" })
