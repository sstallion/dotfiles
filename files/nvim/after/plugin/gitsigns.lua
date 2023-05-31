-- gitsigns.lua - plugin configuration

local gitsigns = require("gitsigns")

-- Adapted from README.md; the resulting keymap will navigate to the
-- next/previous hunk if diff mode is not enabled.
local function unless_diff(mode, lhs, fn, opts)
  if not opts.expr then
    opts.expr = true
  end
  vim.keymap.set(mode, lhs, function()
    if vim.wo.diff then
      return lhs
    else
      vim.schedule(fn)
      return "<Ignore>"
    end
  end, opts)
end

gitsigns.setup {
  signs = {
    add    = { text = "+" },
    change = { text = "~" },
  },
  attach_to_untracked = false,
  on_attach = function(bufnr)
    -- Key Mappings
    local opts = {buffer = bufnr}
    vim.keymap.set("n", "<Leader>hp", gitsigns.preview_hunk, opts)
    vim.keymap.set("n", "<Leader>hr", gitsigns.reset_hunk,   opts)
    vim.keymap.set("n", "<Leader>hR", gitsigns.reset_buffer, opts)
    vim.keymap.set("n", "<Leader>hs", gitsigns.stage_hunk,   opts)
    vim.keymap.set("n", "<Leader>hS", gitsigns.stage_buffer, opts)

    unless_diff("n", "[c", gitsigns.prev_hunk, opts)
    unless_diff("n", "]c", gitsigns.next_hunk, opts)
  end
}
