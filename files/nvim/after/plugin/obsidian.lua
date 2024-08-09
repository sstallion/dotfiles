-- obsidian.lua - plugin configuration

local vault_dir = "~/Notes"
if vim.fn.isdirectory(vim.fn.expand(vault_dir)) == 0 then
  return -- not installed
end

local function new_note(workspace, template)
  local client = require("obsidian").get_client()
  client:switch_workspace(workspace)
  local note = client:create_note { no_write = true } -- dir for path

  client:open_note(note, { sync = true })
  client:write_note_to_buffer(note, { template = template })
  vim.api.nvim_buf_set_lines(0, -2, -1, true, {}) -- delete extraneous line
  vim.fn.search([[^#\s*\w]], "e") -- move cursor to title
end

local function new_zettel()
  new_note("Zettel", "Zettel")
end

local function note_frontmatter(note)
  local out = { tags = note.tags }
  if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    for k, v in pairs(note.metadata) do
      out[k] = v
    end
  end
  return out
end

require("obsidian").setup {
  workspaces = {
    {
      name = "Zettel",
      path = vault_dir,
      overrides = {
        notes_subdir = "Zettel",
        note_id_func = function(title)
          return os.date("%Y%m%d%H%M")
        end,
      },
    },
  },
  preferred_link_style = "markdown",
  note_frontmatter_func = note_frontmatter,
  templates = {
    folder = "Templates",
  },
  use_advanced_uri = true,
  open_app_foreground = true,
  sort_by = "path",
  sort_reversed = false,
  ui = {
    enable = false,
  },
  attachments = {
    img_folder = "Attachments",
  },
}

-- Key Mappings
vim.keymap.set("n", "<Leader>oz", new_zettel)
