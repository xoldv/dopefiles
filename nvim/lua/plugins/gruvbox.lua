return {
	"eddyekofo94/gruvbox-flat.nvim",
	priority = 1000,
	enabled = true,
	config = function()

		vim.g.gruvbox_flat_style = "dark"
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "gruvbox-flat",
			callback = function()

				vim.opt.conceallevel = 1
				vim.api.nvim_set_hl(0, "Visual", { reverse = true })

				vim.cmd([[set cursorline]])
				vim.cmd([[set cursorcolumn]])
				vim.cmd([[highlight clear SignColumn]])

				local diagnostic_colors = {
					Error = { fg = "#cc241d", reverse = true },
					Warn = { fg = "#fabd2f" },
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
					bg = "#b47109",
					fg = "#d5c4a1",
				})
				vim.api.nvim_set_hl(0, "IlluminatedWordWrite", {
					bg = "#504945",
				})
				vim.api.nvim_set_hl(0, "IlluminatedWordText", {
					bg = "#504945",
				})
				vim.opt.termguicolors = true
				-- vim.api.nvim_set_hl(0, "Normal", { bg = "#282828" })
			end,
		})
		vim.g.gruvbox_italic_functions = true

		vim.api.nvim_create_user_command("SetGruvboxFlatStyle", function(opts)
			vim.g.gruvbox_flat_style = opts.args
			vim.cmd("colorscheme gruvbox-flat")
		end, {
			nargs = 1,
			complete = function(_, _, _)
				return { "hard", "dark" }
			end,
		})

		vim.cmd([[colorscheme gruvbox-flat]])
	end,
}
