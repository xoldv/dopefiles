return {
	"kazhala/close-buffers.nvim",
	event = "VeryLazy",
	config = function()
		local close_buffers = require("close_buffers")

		vim.keymap.set("n", "<leader>th", function()
			close_buffers.delete({ type = "hidden" })
		end, { desc = "Close Hidden Buffers" })

		vim.keymap.set("n", "<leader>tu", function()
			close_buffers.delete({ type = "nameless" })
		end, { desc = "Close Nameless Buffers" })
	end,
}
