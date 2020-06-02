" qf.vim - plugin configuration

" Enable ack.vim-inspired mappings in location/quickfix windows:
let g:qf_mapping_ack_style = 1

" Key Mappings
nmap <Leader>l <Plug>(qf_loc_toggle)
nmap [l        <Plug>(qf_loc_previous)
nmap ]l        <Plug>(qf_loc_next)

nmap <Leader>q <Plug>(qf_qf_toggle)
nmap [q        <Plug>(qf_qf_previous)
nmap ]q        <Plug>(qf_qf_next)
