-- possession.lua - plugin configuration

return {
  'jedrzejboczar/possession.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('possession').setup({
      autosave = {
        on_load = false,
        on_quit = false,
      },
      commands = {
        save    = 'SessionSave',
        load    = 'SessionLoad',
        rename  = 'SessionRename',
        close   = 'SessionClose',
        delete  = 'SessionDelete',
        show    = 'SessionShow',
        list    = 'SessionList',
        migrate = 'SessionMigrate',
      },
    })

    require('telescope').load_extension('possession')
  end,
  cmd = {
    'SessionSave',
    'SessionLoad',
    'SessionRename',
    'SessionClose',
    'SessionDelete',
    'SessionShow',
    'SessionList',
    'SessionMigrate'
  },
  keys = {
    { '<Leader>fs', '<Cmd>Telescope possession list previewer=false sort=name theme=dropdown<CR>' },
  },
}
