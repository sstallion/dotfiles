" go.vim - ftplugin configuration

autocmd DiagnosticChanged *.go lua vim.diagnostic.enable(0)
autocmd BufWritePre *.go lua vim.lsp.buf.format()
