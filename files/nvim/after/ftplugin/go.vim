" go.vim - ftplugin configuration

autocmd BufWritePre *.go lua vim.lsp.buf.format()
