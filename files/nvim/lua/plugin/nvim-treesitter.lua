-- nvim-treesitter.lua - plugin configuration

return {
  'nvim-treesitter/nvim-treesitter',
  opts = {
    auto_install = true,
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
  },
  build = ':TSUpdate',
}
