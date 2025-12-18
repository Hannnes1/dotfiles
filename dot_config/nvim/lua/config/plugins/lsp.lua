return {
  {
    "neovim/nvim-lspconfig",
    enabled = not vim.g.vscode,
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      'saadparwaiz1/cmp_luasnip',
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        end,
      })

      local servers = {
        dartls = {
          settings = {
            dart = {
              lineLength = 120,
              analyzerLogFile = '/tmp/dart_analyzer.log',
            },
          },
        },
        html = {},
        cssls = {},
        emmet_ls = {},
        gopls = {},
      }

      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end


      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_vscode').lazy_load({
        paths = {
          '~/.config/nvim/snippets/riverpod',
        },
      })
      require('luasnip.loaders.from_vscode').load_standalone({ path = '~/.config/nvim/snippets/custom.json' })

      local luasnip = require('luasnip')

      vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-H>", function() luasnip.jump(-1) end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, { silent = true })

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip', keyword_length = 2 },
          { name = 'buffer',  keyword_length = 3 },
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
      })
    end,
  },
}
