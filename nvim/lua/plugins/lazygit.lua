return {
    -- for config.yml
    --
    -- os:
    --   editPreset: 'nvim'
    --   # Using -l here to change to the previous window via ":wincmd p".
    --   edit: "nvr -l --remote {{filename}}"

    "kdheepak/lazygit.nvim",
    dependencies = {
        "mhinz/neovim-remote",
    },
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
}
