-- Плагин менеджер окон
return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = true,
			},
			highlights = {
				buffer_selected = {
					italic = true,
					bold = true,
				},
				fill = {fg = "#282828", bg = "#282828"},
			},
		})
		vim.opt.termguicolors = true
	end,
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>1",
		'<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>',
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>2",
		'<cmd>lua require("bufferline").go_to_buffer(2, true)<cr>',
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>3",
		'<cmd>lua require("bufferline").go_to_buffer(3, true)<cr>',
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>4",
		'<cmd>lua require("bufferline").go_to_buffer(4, true)<cr>',
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>5",
		'<cmd>lua require("bufferline").go_to_buffer(5, true)<cr>',
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>6",
		'<cmd>lua require("bufferline").go_to_buffer(6, true)<cr>',
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>7",
		'<cmd>lua require("bufferline").go_to_buffer(7, true)<cr>',
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>8",
		'<cmd>lua require("bufferline").go_to_buffer(8, true)<cr>',
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>9",
		'<cmd>lua require("bufferline").go_to_buffer(9, true)<cr>',
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<LEADER>0",
		'<cmd>lua require("bufferline").go_to_buffer(10, true)<cr>',
		{ noremap = true, silent = true }
	),
}
