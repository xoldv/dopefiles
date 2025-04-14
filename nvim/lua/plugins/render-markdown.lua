return {
    'MeanderingProgrammer/render-markdown.nvim',
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function ()
    require('render-markdown').enable()
    require('render-markdown').setup({
        completions = { lsp = { enabled = true } },
    })
    end,
}
