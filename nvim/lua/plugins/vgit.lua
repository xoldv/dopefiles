return {
  'tanvirtin/vgit.nvim',
  -- Lazy loading on 'VimEnter' event is necessary.
  event = 'VimEnter',
  config = function() require("vgit").setup() end,
}
