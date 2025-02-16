return {
  {
    "tpope/vim-fugitive",
    enabled = not vim.g.vscode,
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end,
  },
}
