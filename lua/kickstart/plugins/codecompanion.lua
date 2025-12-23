return {
  'olimorris/codecompanion.nvim',
  opts = {
    strategies = {
      chat = {
        adapter = 'copilot',
      },
    },
    adapters = {
      copilot = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              default = 'claude-sonnet-4.5',
            },
          },
        })
      end,
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function(_, opts)
    require('codecompanion').setup(opts)
    vim.keymap.set('n', '<leader>ac', ':CodeCompanionChat Toggle<CR>', { desc = 'Toggle CodeCompanionChat' })
  end,
}
