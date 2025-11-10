-- possession.lua - plugin configuration

return {
  'sstallion/possession.nvim', -- see jedrzejboczar/possession.nvim #35
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('lspsession').setup({
      {
        flags = {
          debounce_text_changes = 250,
        },
      },
      ['lua_ls'] = {
        settings = {
          Lua = {
            workspace = {
              -- Disable work environment nag messages:
              checkThirdParty = false,
            },
          },
        },
      },
    })

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
      hooks = {
	before_load = function(name, user_data)
	  require('lspsession').enable(name)
	  return true
	end,
	after_close = function(name)
	  require('lspsession').disable(name)
	end,
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
