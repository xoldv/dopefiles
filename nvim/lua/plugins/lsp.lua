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
		{ "nvimtools/none-ls-extras.nvim" },
	},

	config = function()
		-- Настройка Mason
		require("mason").setup()

		require("mason-null-ls").setup({
			ensure_installed = { "ruff", "stylua", "clang_format", "prettier" },
		})

		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.pretty_php,
				null_ls.builtins.formatting.prettier.with({
					extra_args = { "--tab-width", "4" },
				}),
				require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
				require("none-ls.formatting.ruff_format"),
			},
			on_attach = function(client, bufnr)
				vim.keymap.set("n", "<leader>m", function()
					vim.lsp.buf.format({ async = true })
				end, { noremap = true, silent = true, buffer = bufnr, desc = "Format Code" })
			end,

			vim.keymap.set("n", "<leader>fu", vim.lsp.buf.references, { desc = "Find Usages" }),
			vim.keymap.set("n", "<A-Enter>", vim.lsp.buf.code_action, { desc = "LSP Code Action" }),
		})
	end,
}
