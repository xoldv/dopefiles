-- set italic in treesitter for more readable
local function set_italic(group)
	local current = vim.api.nvim_get_hl(0, { name = group, link = false }) or {}
	current.italic = true
	vim.api.nvim_set_hl(0, group, current)
end

local function apply_italic_highlights()
	set_italic("@keyword")
	set_italic("@function.method.call")
	set_italic("@function.call")
end

-- for fast change light and dark theme
--
vim.api.nvim_create_user_command("ToggleBackground", function()
	if vim.o.background == "light" then
		vim.cmd("set background=dark")
	else
		vim.cmd("set background=light")
	end

	vim.cmd.colorscheme("gruvbox-material")
	vim.api.nvim_set_hl(0, "CursorLine", { bg = vim.o.background == "light" and "#dbddeb" or "#333852" })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = vim.o.background == "light" and "#dbddeb" or "#333852" })
	vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = vim.o.background == "light" and "#ffffff" or "#504945" })
	vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = vim.o.background == "light" and "#ffffff" or "#504945" })
	vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = vim.o.background == "light" and "#ffffff" or "#504945" })
	vim.api.nvim_set_hl(0, "BufferLineFill", { bg = vim.o.background == "light" and "#F9F1CB" or "#282828" })
	apply_italic_highlights()
end, { desc = "Toggle between light and dark background with italics" })

-- keybind for fast change
vim.keymap.set("n", "<M-t>", ":ToggleBackground<CR>", { noremap = true })

return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_enable_italic = 1
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "gruvbox-material",
			callback = function()
				vim.api.nvim_set_hl(0, "Visual", { reverse = true })
				local diagnostic_colors = {
					Error = { fg = "#c14a4a", reverse = true },
					Warn = { fg = "#b47109" },
					Info = { fg = "#458588" },
					Hint = { fg = "#689d6a" },
				}
				for type, color in pairs(diagnostic_colors) do
					vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. type, {
						fg = color.fg,
						bg = "#1d2021",
					})
				end
				-- brackets
				vim.api.nvim_set_hl(0, "MatchParen", { fg = "#fc9487", bg = "#cc241d", bold = true })
				-- for illuminate plugun
				vim.api.nvim_set_hl(0, "IlluminatedWord", { bg = "#b47109" })
				vim.api.nvim_set_hl(0, "IlluminatedWordRead", {
					bg = "#504945",
				})
				vim.api.nvim_set_hl(0, "IlluminatedWordWrite", {
					bg = "#504945",
				})
				vim.api.nvim_set_hl(0, "IlluminatedWordText", {
					bg = "#504945",
				})

				vim.api.nvim_set_hl(0, "CursorLine", { bg = "#333852" })
				vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#333852" })
			end,
		})
		vim.cmd.colorscheme("gruvbox-material")
		apply_italic_highlights()
	end,
}
