return {
  {
    "stevearc/conform.nvim",
    enabled = not vim.g.vscode,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          html = { "prettier" }
        }
      })

      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ lsp_format = "prefer" })
      end)
    end,
  },
}
