vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

vim.keymap.set("n", ";", ":", { noremap = true })
-- fast moving text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- fast change name
vim.keymap.set("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- remove focus to end of line break
vim.keymap.set("n", "J", "mzJ`z")
-- Splits
vim.keymap.set("n", "_", ":vsplit<CR>")
vim.keymap.set("n", "-", ":split<CR>")
-- Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Go to declaration
vim.keymap.set("n", "gd", "<C-]>", { noremap = true, silent = true })

-- I use <C-d> for fast switching between macOS spaces
vim.keymap.set({ "n", "x", "v" }, "<C-y>", "<C-d>", { noremap = true })
vim.keymap.set("n", "<leader>gl", function()
	local word = vim.fn.expand("<cword>")
	vim.cmd("Git log -G" .. word .. " -- .")
end, { desc = "Git log -G <cword>" })

