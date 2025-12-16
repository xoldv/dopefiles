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
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			local function close_debugger()
				dapui.close()
				dap.terminate()
			end

			require("dap-python").setup("/opt/homebrew/bin/python3")
			require("nvim-dap-virtual-text").setup()
			require("persistent-breakpoints").setup({
				load_breakpoints_event = { "BufReadPost" },
			})

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F6>", dap.restart)

			vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
			vim.keymap.set("n", "<leader>?", function()
				dapui.eval(nil, { enter = true })
			end)
			vim.keymap.set("n", "<leader>dq", close_debugger, { desc = "Close DAP UI and terminate debug session" })
			vim.keymap.set("n", "<leader>b", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>")
			vim.keymap.set("n", "<leader>B", "<cmd>lua require('persistent-breakpoints.api').reload_breakpoints()<cr>")
		end,
	},
}
