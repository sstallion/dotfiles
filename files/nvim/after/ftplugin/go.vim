" go.vim - ftplugin configuration

" Autocommands
autocmd DiagnosticChanged *.go lua vim.diagnostic.enable(0)
autocmd BufWritePre *.go lua vim.lsp.buf.format()
