-- vim-codefmt - plugin configuration

return {
  'google/vim-codefmt',
  dependencies = 'google/vim-maktaba',
  cmd = {
    'AutoFormatBuffer',
    'NoAutoFormatBuffer',
    'FormatCode',
    'FormatLines',
  },
}
