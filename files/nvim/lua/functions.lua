-- functions.lua - global functions

-- Convert an existing highlight group to use undercurls.
function hl_undercurl(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  vim.api.nvim_set_hl(0, name, { undercurl = true, sp = hl.sp or hl.fg })
end

-- Convenience function to determine if a window is floating;
-- see api-floatwin.
function is_floating(winid)
  winid = winid or vim.api.nvim_get_current_win()
  return vim.api.nvim_win_get_config(winid).relative ~= ''
end

-- A more usable version of vim.fn.pathshorten().
function pathshorten(path)
  path = vim.fn.fnamemodify(path, ':.')
  if #path > scalewidth(0, 0.5) then
    local dirname = vim.fn.fnamemodify(path, ':h:t')
    local basename = vim.fn.fnamemodify(path, ':t')
    local t = { '…' }
    if dirname ~= '' then
      table.insert(t, dirname)
    end
    table.insert(t, basename)
    if vim.fn.isdirectory(path) == 1 then
      table.insert(t, '')
    end
    path = table.concat(t, vim.fn.expand('/'))
  end
  return path
end

function scaleheight(winid, factor)
  return math.floor(vim.api.nvim_win_get_width(winid)*factor + 0.5)
end

function scalewidth(winid, factor)
  return math.floor(vim.api.nvim_win_get_width(winid)*factor + 0.5)
end
