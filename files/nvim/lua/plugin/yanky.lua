-- yanky.lua - plugin configuration

return {
  'gbprod/yanky.nvim',
  config = function()
    local mapping = require('yanky.telescope.mapping')
    require('yanky').setup({
      ring = {
	history_length = 25,
      },
      highlight = {
	on_put = false,
	on_yank = false,
      },
      picker = {
	telescope = {
	  mappings = {
	    default = mapping.put('p'),
	    i = {
	      ['<c-j>'] = 'move_selection_next',
	      ['<c-k>'] = 'move_selection_previous',
	      ['<c-p>'] = mapping.put('P'),
	      ['<c-x>'] = mapping.delete(),
	    },
	    n = {
	      ['<c-j>'] = 'move_selection_next',
	      ['<c-k>'] = 'move_selection_previous',
	      ['<c-p>'] = mapping.put('P'),
	      ['<c-x>'] = mapping.delete(),
	    },
	  },
	},
      },
    })

    require('telescope').load_extension('yank_history')
  end,
  cmd = {
    'YankyClearHistory',
    'YankyRingHistory',
  },
  keys = {
    { '<Leader>Y',  '<Cmd>YankyClearHistory<CR>' },
    { '<Leader>fy', '<Cmd>Telescope yank_history previewer=false theme=dropdown<CR>' },
    { '<C-N>',      '<Plug>(YankyCycleForward)' },
    { '<C-P>',      '<Plug>(YankyCycleBackward)' },
    { 'p',          '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
    { 'P',          '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },
    { 'gp',         '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' } },
    { 'gP',         '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' } },
  },
}
