-- possession.lua - plugin configuration

require("possession").setup {
  autosave = {
    on_load = false,
    on_quit = false
  },
  commands = {
    save    = "SessionSave",
    load    = "SessionLoad",
    rename  = "SessionRename",
    close   = "SessionClose",
    delete  = "SessionDelete",
    show    = "SessionShow",
    list    = "SessionList",
    migrate = "SessionMigrate"
  },
  hooks = {
    before_load = function(name, user_data)
      require("lspsession").enable(name)
      return true
    end,
    after_close = function(name)
      require("lspsession").disable(name)
    end
  }
}
