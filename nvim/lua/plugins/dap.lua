vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/mfussenegger/nvim-dap-python" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
	{ src = "https://github.com/MironPascalCaseFan/debugmaster.nvim" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
})

local dap = require("dap")
local debugmaster = require("debugmaster")

require("dap-python").setup("/opt/homebrew/bin/debugpy-adapter")
require("dap-go").setup()
require("nvim-dap-virtual-text").setup()

-- debugmaster registers its dap hooks lazily (on first mode toggle); init now so behaviour is always the same
require("debugmaster.plugins").init()
-- keep the side panel with the program output open after the program ends; <leader>dq closes it
for _, event in ipairs({ "event_terminated", "event_exited", "disconnect" }) do
	dap.listeners.before[event]["debugmaster"] = nil
end

vim.keymap.set({ "n", "v" }, "<leader>z", debugmaster.mode.toggle, { nowait = true })
vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint)

vim.keymap.set("n", "<leader>bc", dap.clear_breakpoints)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F6>", dap.restart)

vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
vim.keymap.set("n", "<leader>?", function()
	debugmaster.eval(nil, { enter = true })
end)
vim.keymap.set("n", "<leader>df", function()
	-- the first configuration for the filetype runs the current file (python: "file", go: "Debug")
	local config = (dap.configurations[vim.bo.filetype] or {})[1]
	if not config then
		vim.notify("No DAP configuration for " .. vim.bo.filetype, vim.log.levels.WARN)
		return
	end
	vim.cmd("silent! write")
	-- show the program output in the debugmaster terminal section
	local state = require("debugmaster.state")
	state.sidepanel:set_active_with_open(state.terminal)
	dap.run(config)
end, { desc = "Debug current file" })
vim.keymap.set("n", "<leader>dq", function()
	debugmaster.mode.disable()
	dap.terminate()
	require("debugmaster.state").sidepanel:close()
end, { desc = "Close debugger" })
