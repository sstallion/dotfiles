-- blink.cmp.lua - plugin configuration

return {
  'saghen/blink.cmp',
  config = function()
    local auto_show = false; -- disable by default

    -- Bypass prebuilt binaries on FreeBSD:
    local fuzzy_implementation = 'prefer_rust'
    if vim.fn.has('bsd') then
      fuzzy_implementation = 'lua'
    end

    local cmp = require('blink.cmp')
    cmp.setup({
      keymap = {
        preset = 'default',
        ['<Esc>'] = { 'cancel', 'fallback' },
        ['<C-E']  = { 'cancel', 'fallback' },
        ['<CR>']  = { 'select_and_accept', 'fallback' },
        ['<C-J>'] = { 'select_next', 'fallback_to_mappings' },
        ['<C-K>'] = { 'select_prev', 'fallback_to_mappings' },
      },
      completion = {
        trigger = { prefetch_on_insert = auto_show },
        accept = { auto_brackets = { enabled = false } },
        menu = { auto_show = function() return auto_show end },
      },
      signature = { enabled = true },
      fuzzy = { implementation = fuzzy_implementation },
      cmdline = { enabled = false },
      term = { enabled = false },
    })

    -- Toggle automatic behavior in normal mode:
    vim.keymap.set('n', '<Leader><Space>', function()
      auto_show = not auto_show
    end)
  end,
}
