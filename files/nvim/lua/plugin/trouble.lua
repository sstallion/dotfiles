-- trouble.lua - plugin configuration

return {
  'folke/trouble.nvim',
  config = function()
    require('trouble').setup({
      severity = vim.g.diagnostic_severity, -- see lua/diagnostic.lua
      padding = false,
      action_keys = {
        open_split = { '<C-S>' },
      },
      auto_close = true,
      auto_preview = false,
    })
  end,
  cmd = 'Trouble',
  keys = {
    { '<Leader>d', '<Cmd>Trouble diagnostics toggle<CR>' },
    { '[d',        '<Cmd>Trouble diagnostics prev<CR>' },
    { ']d',        '<Cmd>Trouble diagnostics next<CR>' },
    { '[D',        '<Cmd>Trouble diagnostics first<CR>' },
    { ']D',        '<Cmd>Trouble diagnostics last<CR>' },
  },
}
