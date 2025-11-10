-- mason.lua - plugin configuration

return {
  {
    'mason-org/mason.nvim',
    opts = {},
    build = ':MasonUpdate',
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    opts = {},
  },
}
