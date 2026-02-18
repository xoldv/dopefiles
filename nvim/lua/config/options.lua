vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.opt.colorcolumn = "120"
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.clipboard = "unnamedplus"
vim.o.encoding = "UTF-8"

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indent Settings
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.smartindent = true
vim.o.autoindent = true

-- Visual settings
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.completeopt = "menu,menuone,noselect"
-- File handling
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.swapfile = false
vim.o.backup = false

-- Performance improvements
vim.o.synmaxcol = 300
vim.o.updatetime = 300
vim.o.redrawtime = 10000
vim.o.maxmempattern = 20000
vim.diagnostic.enable = true
vim.diagnostic.config({
	virtual_text = {
		spacing = 2,
	},
	virtual_lines = false,
})

local inactive_statusline = "%#Comment# %<%f %h%m%r%=%-14.(%l,%c%V%) %P %#Normal#"

vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		vim.wo.statusline = ""
	end,
})

vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		vim.wo.statusline = inactive_statusline
	end,
})

vim.api.nvim_create_user_command("Capath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("Crpath", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})


vim.filetype.add({
  extension = {
    json = "jsonc",
  },
})
