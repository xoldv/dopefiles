-- Плагин менеджер окон
return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
    dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = false,
				diagnostics = "nvim_lsp",
				show_buffer_icons = false,
				numbers = "ordinal",
				max_name_length = 15,
				tab_size = 0,
				truncate_names = true,
				indicator = { style = "none" },
				buffer_close_icon = "",
				close_icon = "",
				insert_at_end = true,
				insert_at_start = false,
				-- автопереход на новый буфер
				-- always_show_bufferline = true,
			},
			highlights = {
				buffer_selected = {
					bold = true,
					italic = true,
				},
			},
		})

		local function go_to_visual_buffer(n)
			local buffers = bufferline.get_elements().elements
			local target = buffers[n]
			if target then
				vim.api.nvim_set_current_buf(target.id)
			end
		end

		for i = 1, 9 do
			vim.keymap.set("n", "<A-" .. i .. ">", function()
				go_to_visual_buffer(i)
			end, { noremap = true, silent = true })
		end
		vim.keymap.set("n", "<A-0>", function()
			go_to_visual_buffer(10)
		end, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>p", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin/unpin buffer" })
		vim.keymap.set("n", "<leader>X", ":BufferLineCloseRight<CR>")
		vim.keymap.set("n", "<leader>s", ":BufferLineSortByTabs<CR>")
		vim.keymap.set("n", "<leader>z", ":BufferLineCloseOthers<CR>")
		vim.keymap.set("n", "<Leader>x", function()
			vim.cmd("bdelete")
		end, { noremap = true, silent = true })
	end,
}
