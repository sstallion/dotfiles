-- qf.lua - plugin configuration

require("qf").setup {
  close_other = true,
  silent = true
}

-- link QuickFixLine highlight to CursorLine:
vim.api.nvim_set_hl(0, "QuickFixLine", {link = "CursorLine"})

-- Key Mappings
vim.keymap.set("n", "<Leader>l", "<Cmd>lua require('qf').toggle('l', true)<CR>")
vim.keymap.set("n", "<Leader>L", "<Cmd>lua require('qf').clear('l')<CR>")
vim.keymap.set("n", "<Leader>q", "<Cmd>lua require('qf').toggle('c', true)<CR>")
vim.keymap.set("n", "<Leader>Q", "<Cmd>lua require('qf').clear('c')<CR>")
