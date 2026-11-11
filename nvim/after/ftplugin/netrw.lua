vim.keymap.set("n", ".", function()
	vim.cmd.normal("gn")
	vim.cmd.cd(vim.fn.fnameescape(vim.b.netrw_curdir))
end, { buffer = true, desc = "Set directory as root and cwd" })

vim.keymap.set("n", "<BS>", "-", { buffer = true, remap = true, desc = "Go up a directory" })

vim.keymap.set("n", "gh", function()
	vim.g.netrw_hide = vim.g.netrw_hide == 0 and 1 or 0
	vim.cmd.normal(vim.keycode("<Plug>NetrwRefresh"))
end, { buffer = true, desc = "Toggle hidden files" })

vim.keymap.set("n", "g.", function()
	local dir = vim.fn.fnameescape(vim.g.start_dir)
	vim.cmd.cd(dir)
	vim.cmd("Ntree " .. dir)
end, { buffer = true, desc = "Reset root and cwd to start directory" })
