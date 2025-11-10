-- lspsession.lua - session management for lsp
--[[
  This module provides functions that can be used to implement session-based
  LSP configuration. When a session is loaded, the enable() and disable()
  functions will load a chunk located under stdpath('data')/lspsession/*.lua,
  which must return a table that contains the following keys:

  return {
    diagnostic = true,
    enable = function(name)
      require('lspsession')['lua_ls'].extend({
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
            },
          },
        },
      })
    end,
    disable = function(name)
      require('lspsession')['lua_ls'].restore()
    end,
  }
--]]

local M = {}
local configs = {}
local global = {}

local function load(name)
  local path = string.format('%s/lspsession/%s.lua', vim.fn.stdpath('data'), name)
  if vim.fn.filereadable(vim.fn.expand(path)) == 1 then
    local session = dofile(path)
    vim.validate({
      session = { session, 'table' },
      diagnostic = { session.diagnostic, 'boolean', false },
      enable = { session.enable, 'function', true },
      disable = { session.disable, 'function', true },
    })
    return session
  end
end

function M.enable(name)
  local session = load(name)
  if not session then
    return
  end
  if session.enable then
    session.enable(name)
  end
  if session.diagnostic then
    vim.api.nvim_create_augroup('lspsession', {})
    vim.api.nvim_create_autocmd('DiagnosticChanged', {
      group = 'lspsession',
      callback = function()
        vim.diagnostic.enable(true)
      end,
    })
  end
end

function M.disable(name)
  local session = load(name)
  if not session then
    return
  end
  if session.diagnostic then
    vim.api.nvim_del_augroup_by_name('lspsession')
  end
  if session.disable then
    session.disable(name)
  end
end

function M.setup(defaults)
  -- First unnamed entry contains global defaults:
  if defaults[1] then
    global = defaults[1]
  end
  for name, default in pairs(defaults) do
    if type(name) == 'string' then
      M[name] = vim.tbl_deep_extend('force', global, default)
    end
  end
end

function configs:__index(name)
  if not configs[name] then
    M[name] = vim.deepcopy(global)
  end
  return configs[name]
end

function configs:__newindex(name, default)
  configs[name] = {
    extend = function(config)
      config = vim.tbl_deep_extend('force', default, config)
      vim.lsp.config[name] = config
    end,
    replace = function(config)
      vim.lsp.config[name] = config
    end,
    restore = function()
      vim.lsp.config[name] = default
    end,
  }
end

return setmetatable(M, configs)
