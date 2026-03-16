return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("flutter-tools").setup({
      fvm = true,
      lsp = {
        color = {
          enabled = true,
        },
        settings = {
          lineLength = 120,
          showTodos = true,
        },
      },
    })

    vim.keymap.set("n", "<leader>fo", ":FlutterOutlineToggle<CR>", { desc = "Flutter Outline" })
  end,
}
