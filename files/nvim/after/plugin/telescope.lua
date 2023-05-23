-- telescope.lua - plugin configuration

local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local from_entry = require("telescope.from_entry")
local site = require("site")

-- The following function provides a method of adding results to the
-- quickfix/location list, opening the first result. This required some amount
-- of duplication of send_selected_to_qf() in lua/telescope/actions/init.lua
-- as most actions close the prompt buffer before returning.
local function select_and_open_qf(target)
  return function(prompt_bufnr)
    local action = " " -- create new list (see: setqflist-action)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local manager = picker.manager

    local function entry_to_qf(entry)
      return {
        bufnr = entry.bufnr,
        filename = from_entry.path(entry, false, false),
        lnum = vim.F.if_nil(entry.lnum, 1),
        col = vim.F.if_nil(entry.col, 1),
        text = entry.text
      }
    end

    local qf_entries = {}
    for entry in manager:iter() do
      table.insert(qf_entries, entry_to_qf(entry))
    end

    local prompt = picker:_get_prompt()
    local title = string.format([[%s (%s)]], picker.prompt_title, prompt)

    if target == "loclist" then
      vim.fn.setloclist(picker.original_win_id, qf_entries, action)
      vim.fn.setloclist(picker.original_win_id, {}, "a", {title = title})
    else
      vim.fn.setqflist(qf_entries, action)
      vim.fn.setqflist({}, "a", {title = title})
    end

    actions.select_default(prompt_bufnr)

    -- open window and jump to first result:
    if target == "loclist" then
      actions.open_loclist(prompt_bufnr)
      vim.cmd("lfirst")
    else
      actions.open_qflist(prompt_bufnr)
      vim.cmd("cfirst")
    end
  end
end

telescope.setup {
  defaults = {
    scroll_strategy = "limit",
    prompt_prefix = " 󰍉 ",
    path_display = function(opts, path)
      -- Unfortunately, path_smart() prefixes paths with '../', which is too
      -- distracting when looking at results. We can do better.
      return site.pathshorten(path)
    end,
    mappings = {
      i = {
        ["<c-j>"] = "move_selection_next",
        ["<c-k>"] = "move_selection_previous",
        ["<c-l>"] = select_and_open_qf("loclist"),
        ["<c-q>"] = select_and_open_qf("qflist"),
        ["<c-s>"] = "file_split"
      },
      n = {
        ["<c-j>"] = "move_selection_next",
        ["<c-k>"] = "move_selection_previous",
        ["<c-l>"] = select_and_open_qf("loclist"),
        ["<c-q>"] = select_and_open_qf("qflist"),
        ["<c-s>"] = "file_split"
      }
    },
    preview = false
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown()
    }
  }
}

-- Extensions
telescope.load_extension("possession")
telescope.load_extension("ui-select")
telescope.load_extension("yank_history")

-- Key Mappings
vim.keymap.set("n", "<Leader>fb", "<Cmd>Telescope buffers theme=dropdown sort_mru=true<CR>")
vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope find_files theme=dropdown<CR>")
vim.keymap.set("n", "<Leader>fg", "<Cmd>Telescope live_grep theme=dropdown<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>Telescope help_tags theme=dropdown<CR>")
vim.keymap.set("n", "<Leader>fm", "<Cmd>Telescope vim_bookmarks all theme=dropdown<CR>")
vim.keymap.set("n", "<Leader>fs", "<Cmd>Telescope possession list previewer=false sort=name theme=dropdown<CR>")
vim.keymap.set("n", "<Leader>fy", "<Cmd>Telescope yank_history previewer=false theme=dropdown<CR>")
