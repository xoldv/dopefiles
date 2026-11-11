vim.opt_local.wrap = true
vim.opt_local.conceallevel = 2
vim.opt_local.cursorcolumn = false
vim.opt_local.colorcolumn = "0"
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

vim.keymap.set({ "n", "v" }, "j", "gj", { silent = true, buffer = true })
vim.keymap.set({ "n", "v" }, "k", "gk", { silent = true, buffer = true })
vim.keymap.set("n", "$", "g$", { silent = true, buffer = true })
vim.keymap.set("n", "0", "g0", { silent = true, buffer = true })
vim.keymap.set("n", "^", "g^", { silent = true, buffer = true })
