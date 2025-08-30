-- bufferline.lua - plugin configuration

local bufferline = require("bufferline")
local site = require("site")

bufferline.setup {
  options = {
    mode = "tabs",
    style_preset = {
      bufferline.style_preset.no_italic,
      bufferline.style_preset.no_bold
    },
    numbers = "ordinal",
    close_command = function(tabhandle)
      -- silence E784: Cannot close last tab page
      vim.cmd("silent! tabclose " .. vim.api.nvim_tabpage_get_number(tabhandle))
    end,
    right_mouse_command = false,
    custom_filter = function(buf_number, buf_numbers)
      return not site.is_floating() -- ignore floating windows
    end,
    show_duplicate_prefix = false,
    separator_style = "slant",
    highlights = require("catppuccin.groups.integrations.bufferline").get_theme(),
    show_modified = function(context)
      return not context.tab:current() -- inactive tabs only
    end
  }
}

-- Key Mappings
vim.keymap.set("n", "<Leader>1", "<Cmd>lua require('bufferline').go_to(1, true)<CR>")
vim.keymap.set("n", "<Leader>2", "<Cmd>lua require('bufferline').go_to(2, true)<CR>")
vim.keymap.set("n", "<Leader>3", "<Cmd>lua require('bufferline').go_to(3, true)<CR>")
vim.keymap.set("n", "<Leader>4", "<Cmd>lua require('bufferline').go_to(4, true)<CR>")
vim.keymap.set("n", "<Leader>5", "<Cmd>lua require('bufferline').go_to(5, true)<CR>")
vim.keymap.set("n", "<Leader>6", "<Cmd>lua require('bufferline').go_to(6, true)<CR>")
vim.keymap.set("n", "<Leader>7", "<Cmd>lua require('bufferline').go_to(7, true)<CR>")
vim.keymap.set("n", "<Leader>8", "<Cmd>lua require('bufferline').go_to(8, true)<CR>")
vim.keymap.set("n", "<Leader>9", "<Cmd>lua require('bufferline').go_to(9, true)<CR>")
