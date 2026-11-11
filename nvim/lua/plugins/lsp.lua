vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

--- Reads gci settings from the nearest .golangci.yml (v1 and v2 layouts).
---@param dirname string
---@return string[] sections, boolean custom_order
local function golangci_gci_settings(dirname)
	local config = vim.fs.find({ ".golangci.yml", ".golangci.yaml" }, { path = dirname, upward = true })[1]
	if not config then
		return {}, false
	end
	local ok, lines = pcall(vim.fn.readfile, config)
	if not ok then
		return {}, false
	end

	local sections = {}
	local custom_order = false
	local gci_indent, sections_indent
	for _, line in ipairs(lines) do
		local indent = #line:match("^%s*")
		local is_blank = line:match("^%s*$") or line:match("^%s*#")
		if not is_blank then
			local item = line:match("^%s*-%s*(.-)%s*$")
			if sections_indent and item and indent >= sections_indent then
				item = item:gsub("%s+#.*$", "")
				item = item:gsub("^[\"'](.*)[\"']$", "%1")
				table.insert(sections, item)
			else
				sections_indent = nil
				if gci_indent and indent <= gci_indent then
					gci_indent = nil
				end
				if gci_indent then
					if line:match("^%s*sections:%s*$") then
						sections_indent = indent
					elseif line:match("^%s*custom%-order:%s*true") then
						custom_order = true
					end
				elseif line:match("^%s*gci:%s*$") then
					gci_indent = indent
				end
			end
		end
	end
	return sections, custom_order
end

require("mason").setup()
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		go = { "goimports", "gci", "gofumpt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "jq" },
		jsonc = { "jq" },
		bash = { "shfmt" },
		sh = { "shfmt" },
	},
	formatters = {
		gci = {
			args = function(_, ctx)
				local args = { "write", "--skip-generated", "--skip-vendor" }
				local sections, custom_order = golangci_gci_settings(ctx.dirname)
				for _, section in ipairs(sections) do
					vim.list_extend(args, { "-s", section })
				end
				if custom_order then
					table.insert(args, "--custom-order")
				end
				table.insert(args, "$FILENAME")
				return args
			end,
		},
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
			["<CR>"] = { "accept_and_enter", "fallback" },
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

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities({}, true),
})
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
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config("basedpyright", {
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
	settings = {
		gopls = {
			gofumpt = true,
			completeUnimported = true,
			usePlaceholders = false,
			staticcheck = true,
			semanticTokens = true,
			analyses = {
				unusedparams = true,
				unusedwrite = true,
				nilness = true,
				shadow = true,
			},
		},
	},
})
vim.lsp.enable({ "lua_ls", "basedpyright", "gopls" })

vim.keymap.set("n", "<leader>fu", vim.lsp.buf.references, { desc = "Find Usages" })
vim.keymap.set("n", "<M-Enter>", vim.lsp.buf.code_action)
vim.keymap.set("n", "ms", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>m", function()
	require("conform").format({ async = true })
end)
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float)
