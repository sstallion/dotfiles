-- init.lua - Neovim configuration

require('functions')
require('diagnostic')
require('lsp')

-- Disable deprecation messages:
vim.deprecate = function() end

-- Plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  defaults = {
    version = '*',
  },
  spec = {
    { import = 'plugin' },
  },
  rocks = {
    enabled = false,
  },
  install = {
    colorscheme = { 'catppuccin' },
  },
  change_detection = {
    notify = false,
  },
})

-- Key Mappings
vim.keymap.set('n', '<Esc>', function()
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    if is_floating(winid) then
      vim.api.nvim_win_close(winid, false)
    end
  end
end)
