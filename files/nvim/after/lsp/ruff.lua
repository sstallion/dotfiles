-- ruff.lua - lsp configuration

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports.ruff" } },
      apply = true,
    })
  end,
})

return {}
