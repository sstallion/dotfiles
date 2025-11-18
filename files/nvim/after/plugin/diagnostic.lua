-- diagnostic.lua - diagnostic configuration

local severity = {
  min = vim.diagnostic.severity.WARN,
  max = vim.diagnostic.severity.ERROR,
}

vim.diagnostic.config({
  underline = { severity = severity },
  virtual_text = {
    severity = severity,
    source = false,
  },
  signs = false,
  severity_sort = true,
})

-- Highlight Groups
hl_undercurl('DiagnosticUnderlineError')
hl_undercurl('DiagnosticUnderlineWarn')
hl_undercurl('DiagnosticUnderlineInfo')
hl_undercurl('DiagnosticUnderlineHint')
hl_undercurl('DiagnosticUnderlineOk')
