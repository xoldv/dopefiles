vim.loader.enable()
-- LazyVim
require("config.lazy")
-- Nvim Settings
require("config.configs")
-- -- KeyBindings
require("config.mappings")
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
