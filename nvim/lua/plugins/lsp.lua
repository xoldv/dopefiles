-- LSP 
return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "SmiteshP/nvim-navic" },
        { "jay-babu/mason-null-ls.nvim" },
        { "nvimtools/none-ls.nvim" }

    },

    config = function()
        -- Настройка Mason
        require("mason").setup()

        -- Настройка Mason LSPConfig
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",            -- Для Lua
                "pyright",           -- Для Python
                "cssls",             -- Для CSS
                "emmet_language_server",  -- Для Emmet
                "clangd",            -- Для C/C++
                "ts_ls",          -- Для TypeScript/JavaScript
                "dockerls",          -- Для Docker
                "bashls"
            },
        })

        -- Настройка каждого LSP-сервера
        local lspconfig = require("lspconfig")

        -- Логика подключения серверов
        lspconfig.lua_ls.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
        lspconfig.pyright.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        -- on_new_config = function(config, root_dir)
        --     config.settings.python.pythonPath = get_python_path(root_dir)
        --   end,
        --   settings = {
        --     python = {
        --       analysis = {
        --         autoSearchPaths = true,
        --         useLibraryCodeForTypes = true
        --       }
        --     }
        --   }
        })
        lspconfig.cssls.setup({})
        lspconfig.emmet_language_server.setup({})
        lspconfig.clangd.setup({})
        lspconfig.ts_ls.setup({})
        lspconfig.dockerls.setup({})
        lspconfig.bashls.setup({})
        require("mason-null-ls").setup({
          ensure_installed = { "black" }
        })

        local null_ls = require("null-ls")

        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier.with({
      extra_args = { "--tab-width", "4"}
    })
          },
        on_attach = function(client, bufnr)
                -- Привязка кнопки для форматирования
                vim.keymap.set("n", "<leader>m", function()
                    vim.lsp.buf.format({ async = true })
                end, { noremap = true, silent = true, buffer = bufnr, desc = "Format Code" })

        end,
        })
        --
        --
        -- -- Функция для получения статуса LSP
        -- function LspStatus()
        --   local clients = vim.lsp.get_active_clients()
        --   if #clients == 0 then
        --     return "LSP: Inactive"
        --   end
        --   local names = {}
        --   for _, client in ipairs(clients) do
        --     table.insert(names, client.name)
        --   end
        --   return "LSP: " .. table.concat(names, ", ")
        -- end
        --
        -- -- Установите в статусную строку (если используете встроенную статусную строку)
        -- vim.o.statusline = "%f %y %m %= %l:%c [%p%%] %{v:lua.LspStatus()}"
    end,

}

