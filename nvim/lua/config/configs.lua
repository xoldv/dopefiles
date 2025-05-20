vim.g.did_load_filetypes = 1
vim.g.formatoptions = "qrn1"
vim.opt.showmode = true
vim.opt.updatetime = 100
vim.wo.signcolumn = "no"
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

-- Fillchars
vim.opt.fillchars = {
	vert = "│",
	fold = "⠀",
	-- eob = " ", -- suppress ~ at EndOfBuffer
	-- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}

-- RUSSIAN VODKAAA
-- vim.opt.keymap = "russian-jcukenwin"
vim.opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,"
	.. "фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

vim.cmd([[set cursorline]])
vim.cmd([[set cursorcolumn]])

vim.opt.conceallevel = 1

vim.opt.termguicolors = true


function LspStatus()
	local clients = vim.lsp.get_active_clients()
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
