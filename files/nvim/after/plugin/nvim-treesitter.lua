-- nvim-treesitter.lua - plugin configuration

require("nvim-treesitter.configs").setup {
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}
