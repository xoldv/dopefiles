return {
	"kshenoy/vim-signature",
	config = function()
		vim.keymap.set("n", "<M-]>", "]'", { noremap = true })
		vim.keymap.set("n", "<M-[>", "['", { noremap = true })
	end,
}
