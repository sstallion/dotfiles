-- lsp.lua - LSP configuration

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Prefer builtin formatting when using gq et al.:
    vim.bo[args.buf].formatexpr = nil

    local opts = { buffer = args.buf, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,      opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,  opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references,      opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,     opts)
    vim.keymap.set('n', 'gI', vim.lsp.buf.incoming_calls,  opts)
    vim.keymap.set('n', 'gO', vim.lsp.buf.outgoing_calls,  opts)

    -- Kludge to avoid lack of documentation in cmake-language-server;
    -- cmake_help should probably be rewritten as a hoverProvider.
    if vim.bo[args.buf].filetype ~= 'cmake' then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end

    --[[
    vim.api.nvim_create_autocmd('CursorHold', {
      buffer = args.buf,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd('CursorHoldI', {
      buffer = args.buf,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd('CursorMoved', {
      buffer = args.buf,
      callback = vim.lsp.buf.clear_references,
    })
    --]]
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    vim.cmd('setlocal tagfunc< omnifunc<')
  end,
})
