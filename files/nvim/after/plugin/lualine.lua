-- lualine.lua - plugin configuration

local colors = require("catppuccin.palettes").get_palette()
local vim_icon, vim_color = require("nvim-web-devicons").get_icon_color("vim")
local site = require("site")

local function fileformat()
  local ff = {
    ["dos"]  = "win32",
    ["mac"]  = "mac",
    ["unix"] = "unix"
  }
  if not vim.fn.has(ff[vim.o.fileformat]) then
    return string.format("[%s]", vim.o.fileformat)
  end
  return ""
end

local function nvim_tree_get_cwd()
  local cwd = require("nvim-tree.core").get_cwd()
  return vim.fn.fnamemodify(cwd, ":p:~")
end

local function quickfix_get_name()
  local title
  -- see: https://vi.stackexchange.com/a/18090/27198
  if vim.fn.getloclist(0, {winid = 1}).winid ~= 0 then
    title = vim.fn.getloclist(0, {title = 1}).title
    if title == "" or title:match("^:") then
      return "[Location List]"
    end
  else
    title = vim.fn.getqflist({title = 1}).title
    if title == "" or title:match("^:") then
      return "[Quickfix List]"
    end
  end
  return string.format("[%s]", title)
end

local function filename()
  local ft = { -- special filetypes
    ["NvimTree"]         = nvim_tree_get_cwd,
    ["TelescopePrompt"]  = "[Telescope]",
    ["TelescopeResults"] = "[Telescope]",
    ["Trouble"]          = "[Trouble]",
    ["cmakehelp"]        = "[CMake Help]",
    ["lspinfo"]          = "[LSP]",
    ["mason"]            = "[Mason]",
    ["qf"]               = quickfix_get_name,
    ["vim-plug"]         = "[Plugins]",
    [""]                 = "[No Name]"
  }
  local handler = ft[vim.o.filetype]
  if type(handler) == "string" then
    return handler
  elseif type(handler) == "function" then
    return handler()
  end

  local t = {site.pathshorten(vim.fn.expand("%:.:~"))}
  -- match bufferline.nvim highlighting/symbols:
  if not vim.bo.modifiable or vim.bo.readonly then
    table.insert(t, "%#BufferLineWarning#%*")
  elseif vim.bo.modified then
    table.insert(t, "%#BufferLineModified#●%*")
  end
  return table.concat(t, " ")
end

local function make_option(option, text)
  return {
    function()
      return vim.o[option] and text or ""
    end,
    on_click = function()
      vim.cmd(string.format("set %s!", option))
      require("lualine").refresh()
    end
  }
end

local function make_separator(name, sep, val)
  vim.api.nvim_set_hl(0, name, val)
  return string.format("%%#%s#%s%%*", name, sep)
end

local function toggle_signs()
  -- require("gitsigns").toggle_signs() unusable
  vim.cmd("Gitsigns toggle_signs")
end

local function diagnostics_disable()
  vim.diagnostic.disable(0)
  require("lualine").refresh()
end

local function session_close()
  require("possession.session").close()
end

local function session_list()
  local opts = require("telescope.themes").get_dropdown {
    previewer = false,
    sort = "name"
  }
  require("telescope").extensions.possession.list(opts)
end

-- Report current session name; see: jedrzejboczar/possession.nvim #14.
local function session_name()
    return require("possession.session").session_name or ""
end

-- Remove mode colors from lualine_b component separators.
local lualine_b_separator =
  make_separator("lualine_b_separator", "", {fg = colors.crust, bg = colors.surface1})

require("lualine").setup {
  options = {
    theme = "catppuccin",
    globalstatus = true
  },
  sections = {
    lualine_a = {
      {"mode", icon = {vim_icon, color = {fg = vim_color}}},
      make_option("paste", "PASTE"),
      make_option("hlsearch", "SEARCH"),
      make_option("spell", "SPELL")
    },
    lualine_b = {
      {"branch",
        separator = lualine_b_separator,
        color = {fg = colors.text},
        on_click = toggle_signs
      },
      {"diagnostics",
        separator = lualine_b_separator,
        color = {fg = colors.text},
        sources = {"nvim_workspace_diagnostic"},
        sections = {"error", "warn"}, -- see: site.severity
        on_click = diagnostics_disable
      },
      {session_name,
        separator = lualine_b_separator,
        color = {fg = colors.text, gui = "italic"},
        on_click = session_close -- or session_list
      }
    },
    lualine_c = {filename},
    lualine_x = {fileformat},
    lualine_y = {
      {"progress", color = {fg = colors.text}}
    },
    lualine_z = {
      {"location", --[[icon = "",]] color = {fg = colors.mantle, bg = colors.text}}
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {filename},
    lualine_x = {fileformat},
    lualine_y = {
      {"progress", color = {fg = colors.overlay0}}
    },
    lualine_z = {
      {"location", --[[icon = "",]] color = {fg = colors.overlay0}}
    }
  }
}
