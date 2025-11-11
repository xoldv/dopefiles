vim.opt.showmode = true
vim.opt.updatetime = 100
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.virtualedit = "block"
vim.opt.undofile = true
vim.opt.shell = "/bin/zsh"

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "120"

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Shorter messages
vim.opt.shortmess:append("c")

-- Indent Settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.g.formatoptions = "qrn1"
-- RUSSIAN VODKAAA
-- vim.opt.keymap = "russian-jcukenwin"
vim.opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,"
	.. "фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
vim.opt.keymap = ""
vim.opt.iminsert = 0
vim.opt.imsearch = 0

vim.cmd([[set cursorline]])
vim.cmd([[set cursorcolumn]])

vim.opt.conceallevel = 1
vim.opt.termguicolors = true

function LspStatus()
	local clients = vim.lsp.get_clients()
	if #clients == 0 then
		return "LSP: Inactive"
	end
	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return "LSP: " .. table.concat(names, ", ")
end

vim.o.statusline = "%f %y %m %= %l:%c [%p%%] %{v:lua.LspStatus()}"

-- for nvim >>>>>v0.10.4
vim.diagnostic.config({
	virtual_text = {
		prefix = "",
		format = function(diagnostic)
			return diagnostic.message
		end,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
