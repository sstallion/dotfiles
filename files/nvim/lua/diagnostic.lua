-- diagnostic.lua - diagnostic configuration

vim.g.diagnostic_severity = {
  min = vim.diagnostic.severity.WARN,
  max = vim.diagnostic.severity.ERROR,
}

vim.diagnostic.config({
  underline = {
    severity = vim.g.diagnostic_severity,
  },
  virtual_text = {
    severity = vim.g.diatnostic_severity,
    source = false,
  },
  signs = false,
  severity_sort = true,
})

-- Disable by default:
vim.diagnostic.enable(false)

-- Highlight Groups
hl_undercurl('DiagnosticUnderlineError')
hl_undercurl('DiagnosticUnderlineWarn')
hl_undercurl('DiagnosticUnderlineInfo')
hl_undercurl('DiagnosticUnderlineHint')
hl_undercurl('DiagnosticUnderlineOk')
