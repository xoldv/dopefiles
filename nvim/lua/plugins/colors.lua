vim.pack.add({
	{ src = "https://github.com/IlyasYOY/theme.nvim" },
	{ src = "https://github.com/tjdevries/colorbuddy.nvim" },
})

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

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "ilyasyoy",
	callback = function()
		local diagnostic_colors = {
			Error = { fg = "#5b222c" },
			Warn = { fg = "#7a4d06" },
			Info = { fg = "#458588" },
			Hint = { fg = "#689d6a" },
		}
		for type, color in pairs(diagnostic_colors) do
			vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. type, {
				fg = color.fg,
			})
		end

		for type, color in pairs(diagnostic_colors) do
			vim.api.nvim_set_hl(0, "DiagnosticSign" .. type, {
				fg = color.fg,
			})
		end

		vim.api.nvim_set_hl(0, "StatuslineError", diagnostic_colors.Error)
		vim.api.nvim_set_hl(0, "StatuslineWarn", diagnostic_colors.Warn)
		-- brackets
		vim.api.nvim_set_hl(0, "MatchParen", { fg = "#fc9487", bg = "#cc241d", bold = true })
		-- for illuminate plugun
		vim.api.nvim_set_hl(0, "IlluminatedWord", { bg = "#b47109" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", {
			bg = "#454545",
		})
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", {
			bg = "#454545",
		})
		vim.api.nvim_set_hl(0, "IlluminatedWordText", {
			bg = "#454545",
		})

		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2a2a2a" })

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#689d6a" })
		vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#c2a300" })
		vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#670001" })
		vim.api.nvim_set_hl(0, "NeoTreeGitRenamed", { fg = "#c2a300" })
		vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#6c7086" })
		vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#518199" })
		vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#d787ff" })
	end,
})
vim.cmd.colorscheme("ilyasyoy")
apply_italic_highlights()
