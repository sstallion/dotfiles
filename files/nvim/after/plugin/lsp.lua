-- lsp.lua - plugin configuration

local site = require("site")

-- Close floating windows (hover, cough cough):
vim.keymap.set("n", "<Esc>", function()
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    if site.is_floating(winid) then
      vim.api.nvim_win_close(winid, false)
    end
  end
end)

-- Autocommands
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- Key Mappings
    local opts = {buffer = bufnr, noremap = true, silent = true}
    vim.keymap.set("n", "<Space>k", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<Space>n", vim.lsp.buf.document_highlight, opts)
    vim.keymap.set("n", "<Space>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "K",        vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd",       vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi",       vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr",       vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gt",       vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gD",       vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gI",       vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set("n", "gO",       vim.lsp.buf.outgoing_calls, opts)

    -- Autocommands
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references
    })
  end
})

vim.api.nvim_create_autocmd("LspDetach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    vim.cmd("setlocal tagfunc< omnifunc<")
  end,
})
