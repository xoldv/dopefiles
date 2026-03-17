vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/mfussenegger/nvim-dap-python" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
	{ src = "https://github.com/igorlfs/nvim-dap-view" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
})

local dap = require("dap")
local dapview = require("dap-view")
local breakpoints = require("dap.breakpoints")

dapview.setup()
require("dap-python").setup("/opt/homebrew/bin/python3")
require("dap-go").setup()
require("nvim-dap-virtual-text").setup()

dap.listeners.before.attach.dapui_config = dapview.open
dap.listeners.before.launch.dapui_config = dapview.open

HOME = os.getenv("HOME")
local BREAKPOINTS_DIR = HOME .. "/.cache/dap/"

local function breakpoints_file()
	local cwd = vim.fn.getcwd()
	local project_name = cwd:gsub("/", "_"):gsub("^_", "")
	vim.fn.mkdir(BREAKPOINTS_DIR, "p")
	return BREAKPOINTS_DIR .. project_name .. ".json"
end

function _G.store_breakpoints(clear)
	local path = breakpoints_file()
	local raw = io.open(path, "r")
	local bps = raw and vim.fn.json_decode(raw:read("*a")) or {}
	if raw then
		raw:close()
	end
	local breakpoints_by_buf = breakpoints.get()
	if clear then
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			local file_path = vim.api.nvim_buf_get_name(bufnr)
			if bps[file_path] ~= nil then
				bps[file_path] = {}
			end
		end
	else
		for buf, buf_bps in pairs(breakpoints_by_buf) do
			bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
		end
	end
	local fp = io.open(path, "w")
	fp:write(vim.fn.json_encode(bps))
	fp:close()
end

function _G.load_breakpoints()
	local fp = io.open(breakpoints_file(), "r")
	if not fp then
		return
	end
	local bps = vim.fn.json_decode(fp:read("*a"))
	fp:close()
	local loaded_buffers = {}
	local found = false
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local file_name = vim.api.nvim_buf_get_name(buf)
		if bps[file_name] ~= nil and bps[file_name] ~= {} then
			found = true
		end
		loaded_buffers[file_name] = buf
	end
	if not found then
		return
	end
	for path, buf_bps in pairs(bps) do
		for _, bp in pairs(buf_bps) do
			breakpoints.set({
				condition = bp.condition,
				log_message = bp.logMessage,
				hit_condition = bp.hitCondition,
			}, tonumber(loaded_buffers[path]), bp.line)
		end
	end
end

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*",
	callback = load_breakpoints,
})

vim.keymap.set("n", "<leader>bb", function()
	dap.toggle_breakpoint()
	store_breakpoints(false)
end)
vim.keymap.set("n", "<leader>bc", function()
	dap.clear_breakpoints()
	store_breakpoints(true)
end)

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
