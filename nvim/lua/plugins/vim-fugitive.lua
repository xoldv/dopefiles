return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    config = function ()
        vim.keymap.set("n", "<leader>ga", ":Git blame<CR>")
    end,
  }
}
