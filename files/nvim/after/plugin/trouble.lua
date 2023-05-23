-- trouble.lua - plugin configuration

local trouble = require("trouble")
local site = require("site")

local keymaps = {}

local function replace(mode, lhs, rhs, opts)
  keymaps[lhs] = vim.fn.maparg(lhs, mode, false, true)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function restore(mode, lhs, opts)
  local dict = keymaps[lhs]
  if not dict or vim.tbl_isempty(dict) then
    vim.keymap.del(mode, lhs, opts)
  else
    vim.fn.mapset(mode, lhs, dict)
  end
end

trouble.setup {
  severity = site.severity,
  padding = false,
  action_keys = {
    open_split = {"<C-S>"}
  },
  auto_close = true,
  auto_preview = false
}

-- Key Mappings
vim.keymap.set("n", "<Leader>d", "<Cmd>TroubleToggle<CR>")

-- Autocommands
vim.api.nvim_create_autocmd("FileType", {
  pattern = "Trouble",
  callback = function(args)
    local opts = {skip_groups = true, jump = true}
    replace("n", "[d", function() trouble.previous(opts) end)
    replace("n", "]d", function() trouble.next(opts) end)
    replace("n", "[D", function() trouble.first(opts) end)
    replace("n", "]D", function() trouble.last(opts) end)
  end
})

vim.api.nvim_create_autocmd("BufWipeout", {
  pattern = "Trouble",
  callback = function(args)
    restore("n", "[d")
    restore("n", "]d")
    restore("n", "[D")
    restore("n", "]D")
  end
})
