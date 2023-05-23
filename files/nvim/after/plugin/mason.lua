-- mason.lua - plugin configuration

require("mason").setup {}
require("mason-lspconfig").setup {
  automatic_installation = true
}

require("lspsession").setup_defaults {
  { -- global defaults
    flags = {
      debounce_text_changes = 250
    }
  },
  ["lua_ls"] = {
    settings = {
      Lua = {
        workspace = {
          -- disable work environment nag messages:
          checkThirdParty = false
        }
      }
    }
  }
}

require("mason-lspconfig").setup_handlers {
  function(server_name) -- default handler
    require("lspsession")[server_name].restore()
  end
}
