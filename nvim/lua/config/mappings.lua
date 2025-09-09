vim.g.mapleader = " "

-- Navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<leader>/", ":CommentToggle<CR>")

-- Splits
vim.keymap.set("n", "_", ":vsplit<CR>")
vim.keymap.set("n", "-", ":split<CR>")

-- Other
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Tabs
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<s-Tab>", ":BufferLineCyclePrev<CR>")

-- Go to declaration
vim.api.nvim_set_keymap("n", "gd", "<C-]>", { noremap = true, silent = true })

-- fasting change name
vim.keymap.set("n", "ms", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>rn", "*:%s//")

vim.keymap.set('n', '<C-y>', '<C-d>', { noremap = true })
