return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"Weissle/persistent-breakpoints.nvim",
		},
		config = function()
			require("persistent-breakpoints").setup({
				load_breakpoints_event = { "BufReadPost" },
			})

			require("persistent-breakpoints.api").load_breakpoints()
			local dap = require("dap")
			local ui = require("dapui")
			ui.setup()

			local function close_debugger()
				ui.close()
				dap.terminate()
			end
			require("dap-python").setup("/opt/homebrew/bin/python3")

			require("nvim-dap-virtual-text").setup({
				-- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
				-- display_callback = function(variable)
				-- 	local name = string.lower(variable.name)
				-- 	local value = string.lower(variable.value)
				-- 	if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
				-- 		return "*****"
				-- 	end
				--
				-- 	if #variable.value > 15 then
				-- 		return " " .. string.sub(variable.value, 1, 15) .. "... "
				-- 	end
				--
				-- 	return " " .. variable.value
				-- end,
			})
			vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

			-- Eval var under cursor
			vim.keymap.set("n", "<leader>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F6>", dap.restart)

			vim.keymap.set("n", "<leader>dq", close_debugger, { desc = "Close DAP UI and terminate debug session" })

			vim.keymap.set(
				"n",
				"<leader>b",
				"<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
				{ noremap = true, silent = true }
			)
			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				-- ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				-- ui.close()
			end
		end,
	},
}
