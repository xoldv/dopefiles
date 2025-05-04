-- Плагин менеджер окон
return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = true,
				diagnostics = "nvim_lsp",
				show_buffer_icons = false,
				numbers = "ordinal",
				max_name_length = 10,
				tab_size = 10,
			},
			highlights = {
				buffer_selected = {
					italic = true,
					bold = true,
				},
				fill = { fg = "#282828", bg = "#181818" },
			},
		})

		vim.opt.termguicolors = true

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
	end,
}
