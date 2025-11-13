-- gn.lua - plugin configuration

return {
  url = 'https://gn.googlesource.com/gn',
  config = function()
    local gnpath = vim.fn.stdpath('data') .. '/lazy/gn'
    vim.opt.rtp:append(gnpath .. '/misc/vim')

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'gn',
      command = 'AutoFormatBuffer gn'
    })
  end,
  ft = 'gn',
}
