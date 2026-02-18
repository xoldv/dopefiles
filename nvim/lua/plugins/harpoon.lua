vim.pack.add({
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)

vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- <Esc> - command toggle on macos
-- alacritty.toml
-- [[keyboard.bindings]]
-- key = "1"
-- mods = "Command"
-- chars = "\u001b1"

vim.keymap.set("n", "<Esc>1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<Esc>2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<Esc>3", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<Esc>4", function()
	harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
	harpoon:list():next()
end)
