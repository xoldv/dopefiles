
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- Установить пустую строку статуса, пока lualine не загрузится
      vim.o.statusline = " "
    else
      -- Скрыть строку статуса на стартовой странице
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- Восстановить предыдущий статус строки
    vim.o.laststatus = vim.g.lualine_laststatus

    return {
      options = {
        theme = "gruvbox",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1 }, -- Показ пути файла
        },
        lualine_x = {
          {
            "diff",
            symbols = { added = "+", modified = "~", removed = "-" },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },

            {
              function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                  return msg
                end
                local active_lsps = {}
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    table.insert(active_lsps, client.name)
                  end
                end
                if #active_lsps > 0 then
                  return table.concat(active_lsps, ', ')
                else
                  return msg
                end
              end,
              icon = ' LSP:',
            }
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
        },
        -- lualine_z = {
        --   function()
        --     return " " .. os.date("%R")
        --   end,
        -- },
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }
  end,
}

