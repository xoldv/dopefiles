return {
	"nvim-neotest/neotest",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-neotest/nvim-nio",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-python",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-python")({
					runner = "pytest",
				}),
			},
		})

		vim.keymap.set("n", "<leader>tt", function()
			neotest.run.run()
		end, { desc = "Run nearest test" })
		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run current file" })
		vim.keymap.set("n", "<leader>ta", function()
			neotest.run.run({ suite = true })
		end, { desc = "Run all tests" })
		vim.keymap.set("n", "<leader>ts", function()
			neotest.run.stop()
		end, { desc = "Stop test" })
		vim.keymap.set("n", "<leader>to", function()
			neotest.output_panel.toggle()
		end, { desc = "Toggle output panel" })
		vim.keymap.set("n", "<leader>td", function()
			require("persistent-breakpoints.api").reload_breakpoints()
			neotest.run.run({ strategy = "dap" })
		end, { desc = "Run nearest test in debug" })
		vim.keymap.set("n", "<leader>tD", function()
			require("persistent-breakpoints.api").reload_breakpoints()
			neotest.run.run({ file = vim.fn.expand("%"), strategy = "dap" })
		end, { desc = "Run current test file in debug" })
	end,
}
