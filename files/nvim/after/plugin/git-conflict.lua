-- git-conflict.lua - plugin configuration

require("git-conflict").setup {}

-- Key Mappings
vim.keymap.set("n", "<Leader>x", "<Cmd>GitConflictListQf<CR>")
