-- nvim-tree.lua - plugin configuration

local api = require("nvim-tree.api")
local view = require("nvim-tree.view")
local site = require("site")

-- An alternate hijacking method is needed to support editing directories in a
-- floating window. The directory buffer is removed after entry and the tree
-- is scheduled to be focused after the autocommand completes.
local function hijack_directory()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if vim.fn.isdirectory(bufname) == 1 and not view.is_visible() then
    vim.cmd("bdelete!")
    api.tree.open {path = bufname}
    vim.schedule(api.tree.focus)
  end
end

-- duplicated from lua/nvim-tree/view.lua:
local function is_buf_displayed(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr) and vim.fn.buflisted(bufnr) == 1
end

-- Care must be taken to avoid interacting with the tree from within a
-- floating window without an alternate buffer as this will lead to an
-- exception.
local function provide_alt(fn, ...)
  if site.is_floating() and vim.bo.filetype ~= "NvimTree" then
    local bufnr = vim.fn.bufnr("#")
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if vim.fn.isdirectory(bufname) ~= 1 and is_buf_displayed(bufnr) then
      vim.cmd("sbuffer " .. bufnr)
    else
      vim.cmd("new")
    end
  end
  return fn(...)
end

local function open_parent()
  local path = vim.fn.expand("%:p:h")
  provide_alt(api.tree.open, {path = path, find_file = true})
end

local function toggle()
  provide_alt(api.tree.toggle, {path = vim.fn.getcwd(), find_file = true})
end

require("nvim-tree").setup {
  disable_netrw = true,
  sort_by = "case_sensitive",
  hijack_directories = {
    enable = false -- see: hijack_directory()
  },
  on_attach = function(bufnr)
    local function opts(desc)
      return {desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
    end
    vim.keymap.set("n", "<C-S>", api.node.open.horizontal,       opts("Open: Horizontal Split"))
    vim.keymap.set("n", "<C-T>", api.node.open.tab,              opts("Open: New Tab"))
    vim.keymap.set("n", "<C-V>", api.node.open.vertical,         opts("Open: Vertical Split"))
    vim.keymap.set("n", "<BS>",  api.node.navigate.parent_close, opts("Close Directory"))
    vim.keymap.set("n", "<CR>",  api.node.open.edit,             opts("Open"))
    vim.keymap.set("n", "<Esc>", api.tree.close,                 opts("Close"))
    vim.keymap.set("n", "-",     api.tree.change_root_to_parent, opts("Up"))
    vim.keymap.set("n", "%",     api.fs.create,                  opts("Create"))
    vim.keymap.set("n", "D",     api.fs.remove,                  opts("Delete"))
    vim.keymap.set("n", "R",     api.fs.rename,                  opts("Rename"))
    vim.keymap.set("n", "g?",    api.tree.toggle_help,           opts("Help"))
    vim.keymap.set("n", "gx",    api.node.run.system,            opts("Run System"))
    vim.keymap.set("n", "y",     api.fs.copy.filename,           opts("Copy Name"))
  end,
  view = {
    float = {
      enable = true,
      open_win_config = function()
        -- Open float relative to the current window. This avoids whiplash
        -- working on ultrawide displays.
        local winid = vim.api.nvim_get_current_win()
        local _, col = unpack(vim.fn.win_screenpos(winid))
        local width = math.min(site.scalewidth(winid, 1.0), 38) - 4 -- fit between separators
        local height = vim.o.lines - vim.o.cmdheight - 4 -- fit between statusline/tabline
        return {
          border = 'rounded',
          relative = 'editor',
          row = 1,
          col = col,
          width = width,
          height = height
        }
      end
    }
  },
  actions = {
    change_dir = {
      enable = false,
      global = true
    },
    open_file = {
      window_picker = {
        enable = false
      }
    }
  },
  renderer = {
    add_trailing = true,
    icons = {
      show = {
        git = false
      }
    },
    special_files = {},
    symlink_destination = false
  }
}

-- Key Mappings
vim.keymap.set("n", "<Leader>t", toggle)
vim.keymap.set("n", "-",         open_parent)

-- Autocommands
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
  callback = hijack_directory
})
