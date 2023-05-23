-- diagnostic.lua -- plugin configuration

local site = require("site")

local goto_opts = {
  wrap = false,
  severity = site.severity,
  float = false
}

local function if_enabled(fn, ...)
  local args = ...
  return function()
    local bufnr = vim.api.nvim_get_current_buf()
    if not vim.diagnostic.is_disabled(bufnr) then
      return fn(args)
    end
  end
end

vim.diagnostic.config {
  underline = {
    severity = site.severity
  },
  virtual_text = {
    severity = site.severity,
    source = false
  },
  signs = false,
  severity_sort = true
}

-- Disable diagnostics by default; see: neovim/neovim #3786.
--vim.diagnostic.disable()
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end
})

-- Highlight Groups
site.hl_undercurl("DiagnosticUnderlineError")
site.hl_undercurl("DiagnosticUnderlineWarn")
site.hl_undercurl("DiagnosticUnderlineInfo")
site.hl_undercurl("DiagnosticUnderlineHint")
site.hl_undercurl("DiagnosticUnderlineOk")

-- Key Mappings
vim.keymap.set("n", "[d", if_enabled(vim.diagnostic.goto_prev, goto_opts))
vim.keymap.set("n", "]d", if_enabled(vim.diagnostic.goto_next, goto_opts))
