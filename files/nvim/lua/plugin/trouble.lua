-- trouble.lua - plugin configuration

return {
  'folke/trouble.nvim',
  config = function()
    require('trouble').setup({
      auto_close = true,
      auto_preview = false,
      warn_no_results = false,
    })
  end,
  cmd = 'Trouble',
  keys = {
    { '<Leader>d', '<Cmd>Trouble diagnostics toggle focus=false<CR>' },
    { '[d',        '<Cmd>Trouble diagnostics prev jump=true<CR>' },
    { ']d',        '<Cmd>Trouble diagnostics next jump=true<CR>' },
    { '[D',        '<Cmd>Trouble diagnostics first jump=true<CR>' },
    { ']D',        '<Cmd>Trouble diagnostics last jump=true<CR>' },
  },
}
