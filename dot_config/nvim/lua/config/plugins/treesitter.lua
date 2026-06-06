return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    enabled = not vim.g.vscode,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').setup {
        ensure_installed = { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "json", "jsonc", "latex" },
        auto_install = true,
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require 'treesitter-context'.setup {
        multiline_threshold = 1,
      }
    end,
  },
}

