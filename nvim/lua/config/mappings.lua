-- Navigation
-- vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
-- vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
-- vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
-- vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.keymap.set({ "n", "x", "v" }, "<C-y>", "<C-d>", { noremap = true })
vim.keymap.set("n", "<M-,>", "<C-w>5<")
vim.keymap.set("n", "<M-.>", "<C-w>5>")
vim.keymap.set("n", "<M-m>", "<C-w>-")
vim.keymap.set("n", "<M-n>", "<C-w>+")
-- fast moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- remove focus to end of line break
vim.keymap.set("n", "J", "mzJ`z")
-- Splits
vim.keymap.set("n", "_", ":vsplit<CR>")
vim.keymap.set("n", "-", ":split<CR>")

vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Go to declaration
vim.api.nvim_set_keymap("n", "gd", "<C-]>", { noremap = true, silent = true })

-- fast change name
vim.keymap.set("n", "ms", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>rl", "<cmd>LspRestart<cr>")
-- It pastes over selected text without overwriting the clipboard.
vim.keymap.set("x", "<leader>p", [["_dP]])
-- delete without overwriting the clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end, opts)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end, opts)

vim.keymap.set("n", "<leader>du", require("config.find_usages").delete_if_unused, { desc = "Delete if unused" })
vim.keymap.set("n", "*", "*N", { noremap = true, silent = true })
