-- qf.lua - plugin configuration

return {
  'sstallion/qf.nvim', -- see ten3roberts/qf.nvim #16
  init = function()
    -- Link QuickFixLine highlight to CursorLine:
    vim.api.nvim_set_hl(0, 'QuickFixLine', { link = 'CursorLine' })
  end,
  opts = {},
  lazy = false,
  keys = {
    { '<Leader>l', [[<Cmd>lua require('qf').toggle('l', true)<CR>]] },
    { '<Leader>L', [[<Cmd>lua require('qf').clear('l')<CR>]] },
    { '<Leader>q', [[<Cmd>lua require('qf').toggle('c', true)<CR>]] },
    { '<Leader>Q', [[<Cmd>lua require('qf').clear('c')<CR>]] },
  },
}
