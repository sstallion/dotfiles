-- obsidian.lua - plugin configuration

vim.g.obsidian_vault_dir = vim.fn.expand('~/Notes')
vim.g.obsidian_workspace = 'Zettel'
vim.g.obsidian_templates = {
  ['Zettel'] = 'Zettel',
}

return {
  'epwalsh/obsidian.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  enabled = function()
    return vim.fn.isdirectory(vim.g.obsidian_vault_dir) ~= 0
  end,
  init = function()
    vim.filetype.add({
      extension = {
	md = function(path, bufnr)
	  prefix = vim.fn.expand(vim.g.obsidian_vault_dir)
	  if path:find(prefix) == 1 then
	    return 'obsidian'
	  end
	  return 'markdown'
	end
      }
    })

    vim.treesitter.language.register('markdown', 'obsidian')
  end,
  config = function()
    local function note_frontmatter(note)
      if next(note.tags) == nil then
	return {}
      end
      local out = { tags = note.tags }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
	for k, v in pairs(note.metadata) do
	  out[k] = v
	end
      end
      return out
    end

    require('obsidian').setup({
      workspaces = {
	{
	  name = vim.g.obsidian_workspace,
	  path = vim.g.obsidian_vault_dir,
	  overrides = {
	    notes_subdir = 'Zettel',
	    note_id_func = function(title)
	      return os.date('%Y%m%d%H%M')
	    end,
	  },
	},
      },
      preferred_link_style = 'markdown',
      note_frontmatter_func = note_frontmatter,
      templates = {
	folder = 'Templates',
      },
      use_advanced_uri = true,
      open_app_foreground = true,
      sort_by = 'path',
      sort_reversed = false,
      ui = {
	enable = false,
      },
      attachments = {
	img_folder = 'Attachments',
      },
    })

    vim.api.nvim_create_user_command('ZettelNew', function()
      local client = require('obsidian').get_client()
      client:switch_workspace(vim.g.obsidian_workspace)

      local template = vim.g.obsidian_templates[vim.g.obsidian_workspace]
      local note = client:create_note { no_write = true } -- dir for path
      client:open_note(note, { sync = true })
      client:write_note_to_buffer(note, { template = template })
      vim.api.nvim_buf_set_lines(0, -2, -1, true, {}) -- delete extraneous line
      vim.fn.search([[^#\s*\w]], 'e') -- move cursor to title
    end, { desc = 'Creates a new Zettel in Obsidian' })
  end,
  cmd = 'ZettelNew',
  ft = 'obsidian',
  keys = {
    { '<Leader>oz', '<Cmd>ZettelNew<CR>' },
  },
}
