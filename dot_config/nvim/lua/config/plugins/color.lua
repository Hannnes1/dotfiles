return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  enabled = not vim.g.vscode,
  config = function()
    require('tokyonight').setup({
      style = "moon",
      on_highlights = function(hl)
        hl.ColorColumn = {
          bg = "#25273d"
        }
      end
    })

    vim.cmd.colorscheme "tokyonight"
  end,
}
