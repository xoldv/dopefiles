vim.g.mapleader = " "

-- Nvim-Tree
-- vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

-- Navigation
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<leader>/', ':CommentToggle<CR>')

-- Splits
vim.keymap.set('n', '_', ':vsplit<CR>')
vim.keymap.set('n', '-', ':split<CR>')

-- Other
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>x', ':BufferLinePickClose<CR>')
vim.keymap.set('n', '<leader>X', ':BufferLineCloseRight<CR>')
vim.keymap.set('n', '<leader>s', ':BufferLineSortByTabs<CR>')
vim.keymap.set('n', '<leader>z', ':BufferLineCloseOthers<CR>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Tabs
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<s-Tab>', ':BufferLineCyclePrev<CR>')

-- Debug ( DAP )
vim.keymap.set('n', '<Leader>dt', ':DapToggleBreakpoint<CR>')
vim.keymap.set('n', '<Leader>dc', ':DapContinue<CR>')
vim.keymap.set('n', '<F2>', ':DapStepOver<CR>')
vim.keymap.set('n', '<F3>', ':DapStepInto<CR>')
vim.keymap.set('n', '<F4>', ':DapStepOut<CR>')

-- Go to declaration
vim.api.nvim_set_keymap('n', 'gd', '<C-]>', { noremap = true, silent = true })

-- fasting change name
vim.keymap.set('n', 'ms', '*:%s//')
