-- vim-bookmarks.lua - plugin configuration

return {
  'MattesGroeger/vim-bookmarks',
  dependencies = 'tom-anders/telescope-vim-bookmarks.nvim',
  init = function()
    vim.g.bookmark_no_default_key_mappings = true

    -- Prefer Location List to QuickFix List for bookmarks;
    -- see https://github.com/MattesGroeger/vim-bookmarks/pull/97.
    vim.g.bookmark_location_list = true

    vim.g.bookmark_sign = ''
    vim.g.bookmark_annotation_sign = '󰃁'
  end,
  config = function()
    require('telescope').load_extension('vim_bookmarks')
  end,
  cmd = {
    'BookmarkAnnotate',
    'BookmarkClear',
    'BookmarkClearAll',
    'BookmarkLoad',
    'BookmarkNext',
    'BookmarkPrev',
    'BookmarkSave',
    'BookmarkShowAll',
    'BookmarkToggle',
  },
  keys = {
    { '<Leader>fm', '<Cmd>Telescope vim_bookmarks all theme=dropdown<CR>' },
    { '<Leader>m',  '<Cmd>BookmarkShowAll<CR>' },
    { '<Leader>M',  '<Cmd>BookmarkClearAll<CR>' },
    { '[m',         '<Cmd>BookmarkPrev<CR>' },
    { ']m',         '<Cmd>BookmarkNext<CR>' },
    { 'ma',         '<Cmd>BookmarkAnnotate<CR>' },
    { 'mm',         '<Cmd>BookmarkToggle<CR>' },
  },
}
