vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require("mason").setup()
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		go = { "golangci-lint" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "jq" },
		jsonc = { "jq" },
		bash = { "shfmt" },
		sh = { "shfmt" },
	},
	formatters = {
		jq = {
			command = "jq",
			args = { "-S", "--indent", "2", "--ascii-output", "." },
		},
		prettier = {
			args = {
				"--tab-width",
				"4",
				"--use-tabs",
				"false",
				"--stdin-filepath",
				"$FILENAME",
			},
		},
	},
})

require("blink.cmp").setup({
	signature = { enabled = true },
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<C-e>"] = { "hide" },
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		list = {
			selection = {
				preselect = false,
			},
		},
	},
	sources = {
		default = { "lsp", "path", "buffer" },
		providers = {
			buffer = { score_offset = 5 },
		},
	},
	cmdline = {
		enabled = true,
		completion = {
			menu = { auto_show = true },
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
		},
		keymap = {
			preset = "none",
			["<Tab>"] = { "select_next", "show", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		sources = function()
			local type = vim.fn.getcmdtype()
			if type == "/" or type == "?" then
				return { "buffer" }
			end
			if type == ":" then
				return { "cmdline", "path" }
			end
			return {}
		end,
	},
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.enable({ "lua_ls", "basedpyright", "gopls", "tsserver" })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			wowrkspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
	capabilities = capabilities,
})

vim.lsp.config("basedpyright", {
	capabilities = capabilities,
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "workspace",
				autoImportCompletions = true,
			},
		},
	},
})
vim.lsp.config("gopls", {
	capabilities = capabilities,
	settings = {
		gopls = {
			gofumpt = true,
			completeUnimported = true,
			usePlaceholders = false,
			staticcheck = true,
		},
	},
})
vim.lsp.config("tsserver", { capabilities = capabilities })

vim.keymap.set("n", "<leader>fu", vim.lsp.buf.references, { desc = "Find Usages" })
vim.keymap.set("n", "<M-Enter>", vim.lsp.buf.code_action)
vim.keymap.set("n", "ms", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>m", function()
	require("conform").format({ async = true })
end)
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float)
