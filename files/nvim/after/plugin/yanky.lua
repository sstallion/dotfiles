-- yanky.lua - plugin configuration

local mapping = require("yanky.telescope.mapping")

require("yanky").setup {
  ring = {
    history_length = 25
  },
  highlight = {
    on_put = false,
    on_yank = false
  },
  picker = {
    telescope = {
      mappings = {
        default = mapping.put("p"),
        i = {
          ["<c-j>"] = "move_selection_next",
          ["<c-k>"] = "move_selection_previous",
          ["<c-p>"] = mapping.put("P"),
          ["<c-x>"] = mapping.delete()
        },
        n = {
          ["<c-j>"] = "move_selection_next",
          ["<c-k>"] = "move_selection_previous",
          ["<c-p>"] = mapping.put("P"),
          ["<c-x>"] = mapping.delete()
        }
      }
    }
  }
}

-- Key Mappings
vim.keymap.set("n", "<Leader>Y", "<Cmd>YankyClearHistory<CR>")
vim.keymap.set("n", "<C-N>",     "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<C-P>",     "<Plug>(YankyCycleBackward)")

vim.keymap.set({"n", "x"}, "p",  "<Plug>(YankyPutAfter)")
vim.keymap.set({"n", "x"}, "P",  "<Plug>(YankyPutBefore)")
vim.keymap.set({"n", "x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n", "x"}, "gP", "<Plug>(YankyGPutBefore)")
