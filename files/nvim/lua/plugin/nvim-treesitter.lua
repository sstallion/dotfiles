-- nvim-treesitter.lua - plugin configuration

return {
  'nvim-treesitter/nvim-treesitter',
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  build = ':TSUpdate',
}
