-- vim-tmux-navigator.lua - plugin configuration

return {
  'christoomey/vim-tmux-navigator',
  cond = function()
    return os.getenv('TMUX') ~= nil
  end,
  init = function()
    -- Disable default vim-tmux-navigator key mappings and save buffers:
    vim.g.tmux_navigator_no_mappings = true
    vim.g.tmux_navigator_save_on_switch = 2
  end,
  keys = {
    { '<C-W>h', '<Cmd>TmuxNavigateLeft<CR>', silent = true },
    { '<C-W>j', '<Cmd>TmuxNavigateDown<CR>', silent = true },
    { '<C-W>k', '<Cmd>TmuxNavigateUp<CR>', silent = true },
    { '<C-W>l', '<Cmd>TmuxNavigateRight<CR>', silent = true },
  },
}
