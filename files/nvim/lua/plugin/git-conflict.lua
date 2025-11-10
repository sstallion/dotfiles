-- git-conflict.lua - plug configuration

return {
  'akinsho/git-conflict.nvim',
  opts = {
    disable_diagnostics = true,
  },
  keys = {
    { '<Leader>x', '<Cmd>GitConflictListQf<CR>' },
  },
  lazy = false,
}
