vim.pack.add({
    {src = "https://github.com/xoldv/noir.nvim"}
})
vim.cmd.colorscheme("noir")
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#101010"})

