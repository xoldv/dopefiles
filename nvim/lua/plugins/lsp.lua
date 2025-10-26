return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"jay-babu/mason-null-ls.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		-- "L3MON4D3/LuaSnip",
		-- "saadparwaiz1/cmp_luasnip",
		"nvimtools/none-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
		"j-hui/fidget.nvim",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
	},

	config = function()
		require("mason").setup()
		require("mason-null-ls").setup({
			ensure_installed = { "ruff", "stylua", "clang_format", "prettier" },
		})
		require("fidget").setup()

		local null_ls = require("null-ls")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered()
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "vsnip" }, -- For vsnip users.
			}, { { name = "buffer" }, { name = "nvim_lsp_signature_help" } }),
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
			}, { { name = "buffer" } }),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
		})
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
		})

		vim.lsp.config("lua_ls", { capabilities = capabilities })
		vim.lsp.config("basedpyright", { capabilities = capabilities })
		-- vim.lsp.config("pyright", { capabilities = capabilities })
		vim.lsp.config("emmet_language_server", { capabilities = capabilities })
		vim.lsp.config("clangd", { capabilities = capabilities })

		vim.lsp.enable("lua_ls")
		vim.lsp.enable("basedpyright")
		-- vim.lsp.enable("pyright")
		vim.lsp.enable("emmet_language_server")
		vim.lsp.enable("clangd")

		vim.keymap.set("n", "<leader>fu", vim.lsp.buf.references, { desc = "Find Usages" })
		vim.keymap.set("n", "<A-Enter>", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
	end,
}
