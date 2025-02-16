return {
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = not vim.g.vscode,
    config = function()
      require('ibl').setup()
    end,
  },
}
