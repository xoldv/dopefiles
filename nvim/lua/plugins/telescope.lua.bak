-- Плагин для быстрой навигации по файлам
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  -- branch = "v3.x",
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
    end,
    },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "venv",
          "__pycache__",
        },
      },
    }

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>FW', function()
      builtin.find_files({ hidden = true })
    end, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
    vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, {})
    vim.keymap.set('n', 'gr', builtin.lsp_references, { noremap = true, silent = true })
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, { noremap = true, silent = true })
  end,
}

