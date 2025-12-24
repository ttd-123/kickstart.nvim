return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'codecompanion' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    latex = {
      enabled = true,
      converter = 'latex2unicode',
      highlight = 'RenderMarkdownMath',
    },
  },
}
