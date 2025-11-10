-- qf.lua - plugin configuration

return {
  'ten3roberts/qf.nvim',
  config = function()
    require('qf').setup({
      close_other = true,
      silent = true,
    })

    -- Link QuickFixLine highlight to CursorLine:
    vim.api.nvim_set_hl(0, 'QuickFixLine', { link = 'CursorLine' })
  end,
  keys = {
    { '<Leader>l', [[<Cmd>lua require('qf').toggle('l', true)<CR>]] },
    { '<Leader>L', [[<Cmd>lua require('qf').clear('l')<CR>]] },
    { '<Leader>q', [[<Cmd>lua require('qf').toggle('c', true)<CR>]] },
    { '<Leader>Q', [[<Cmd>lua require('qf').clear('c')<CR>]] },
  },
}
