-- LSP
return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		{ "mason-org/mason.nvim" },
		{ "mason-org/mason-lspconfig.nvim" },
		{ "SmiteshP/nvim-navic" },
		{ "jay-babu/mason-null-ls.nvim" },
		{ "nvimtools/none-ls.nvim" },
		{ "stevearc/conform.nvim" },
	},

	config = function()
		-- Настройка Mason
		require("mason").setup()

		-- Настройка Mason LSPConfig
		-- не ворк после обновы
		-- require("mason-lspconfig").setup({
		-- 	ensure_installed = {
		-- 		"emmet_language_server", -- Для Emmet
		-- 		"lua_ls", -- Для Lua
		-- 		"pyright", -- Для Python
		-- 		"clangd", -- Для C/C++
		-- 	},
		-- })

		-- Настройка каждого LSP-сервера
		local lspconfig = require("lspconfig")

		-- Логика подключения серверов
		lspconfig.lua_ls.setup({
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
		lspconfig.pyright.setup({
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
		lspconfig.emmet_language_server.setup({})
		lspconfig.clangd.setup({})
		lspconfig.ts_ls.setup({})
		lspconfig.intelephense.setup({})
		require("mason-null-ls").setup({
			ensure_installed = { "ruff", "stylua", "clang_format", "prettier" },
		})

		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.pretty_php,
				null_ls.builtins.formatting.prettier.with({
					extra_args = { "--tab-width", "4" },
				}),
			},
			on_attach = function(client, bufnr)
				-- Привязка кнопки для форматирования
				vim.keymap.set("n", "<leader>m", function()
					vim.lsp.buf.format({ async = true })
				end, { noremap = true, silent = true, buffer = bufnr, desc = "Format Code" })
			end,
		})
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				python = {
					"ruff_fix", -- To fix lint errors. (ruff with argument --fix)
					"ruff_format", -- To run the formatter. (ruff with argument format)
				},
			},
		})
		vim.keymap.set("n", "<leader>m", function()
			conform.format()
		end, { noremap = true, silent = true, desc = "Conform Format" })
	end,
}
