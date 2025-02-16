return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  enabled = not vim.g.vscode,
  config = function()
    require('lualine').setup {
      sections = {
        lualine_c = { { 'filename', path = 1 } },
      },
      options = {
        theme = 'tokyonight',
      },
    }
  end,
}
