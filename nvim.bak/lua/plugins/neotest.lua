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
					args = {
						"-vv",
						"--showlocals",
						"--tb=short",
						"--assert=rewrite",
					},
				}),
			},
			consumers = {
				diff_helper = function(client)
					return {
						get_nearest = function(file_path, row, args)
							return client:get_nearest(file_path, row, args)
						end,
						get_results = function(adapter_id)
							return client:get_results(adapter_id)
						end,
					}
				end,
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

		vim.keymap.set("n", "<leader>tD", function()
			neotest.run.run({ file = vim.fn.expand("%"), strategy = "dap" })
		end, { desc = "Run current test file in debug" })

		vim.keymap.set("n", "<leader>ti", function()
			local file_path = vim.fn.expand("%:p")
			local row = vim.fn.getpos(".")[2] - 1
			-- Uses the custom consumer we added in setup
			local tree, adapter_id = neotest.diff_helper.get_nearest(file_path, row, {})

			if not tree then
				vim.notify("No test found at cursor", vim.log.levels.WARN)
				return
			end

			local pos_id = tree:data().id
			local results = neotest.diff_helper.get_results(adapter_id)
			local result = results and results[pos_id]

			if not result then
				vim.notify("No test result found", vim.log.levels.WARN)
				return
			end

			if result.status ~= "failed" then
				vim.notify("Test did not fail", vim.log.levels.INFO)
				return
			end

			local output_file = result.output
			if not output_file then
				return
			end

			local lines = {}
			local f = io.open(output_file, "r")
			if f then
				for line in f:lines() do
					table.insert(lines, line)
				end
				f:close()
			end

			local expected = {}
			local actual = {}

			for _, line in ipairs(lines) do
				-- Strip ANSI codes
				line = line:gsub("\27%[[0-9;]*m", "")
				-- Strip carriage returns
				line = line:gsub("\r", "")

				-- Pytest diffs usually have 'E' followed by spaces, then a sign (+, -, ?) or space for context.
				-- We capture the sign and the rest of the content.
				local sign, content = line:match("^E%s+([%+%-%s])(.*)")

				if sign then
					if sign == "-" then
						table.insert(expected, content)
					elseif sign == "+" then
						table.insert(actual, content)
					elseif sign == " " or sign == "" then
						table.insert(expected, content)
						table.insert(actual, content)
					end
				end
			end

			if #expected == 0 or #actual == 0 then
				vim.notify("No diff found in output", vim.log.levels.WARN)
				return
			end

			-- Clean up previous buffers if they exist to avoid name conflicts
			for _, name in ipairs({ "Expected_Result", "Actual_Result" }) do
				local old_buf = vim.fn.bufnr(name)
				if old_buf ~= -1 then
					vim.api.nvim_buf_delete(old_buf, { force = true })
				end
			end

			-- Create Diff View
			vim.cmd("tabnew")

			-- Buffer 1: Expected
			local buf_expected = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf_expected, 0, -1, false, expected)
			vim.api.nvim_buf_set_name(buf_expected, "Expected_Result")
			vim.api.nvim_set_current_buf(buf_expected)
			vim.bo.filetype = "python"
			vim.cmd("diffthis")

			-- Buffer 2: Actual
			vim.cmd("vsplit")
			local buf_actual = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf_actual, 0, -1, false, actual)
			vim.api.nvim_buf_set_name(buf_actual, "Actual_Result")
			vim.api.nvim_set_current_buf(buf_actual)
			vim.bo.filetype = "python"
			vim.cmd("diffthis")
		end, { desc = "Show Expected vs Actual Diff" })
	end,
}
