let g:gitgutter_sign_added = 'ﰠ'
let g:gitgutter_sign_modified = '狀'
let g:gitgutter_sign_removed = 'ﰡ'
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = '識'

let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0

highlight GitGutterAdd           term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#1d2021 guifg=Grey
highlight GitGutterChange        term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#1d2021 guifg=#076678
highlight GitGutterDelete        term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#1d2021 guifg=#fb4934
highlight GitGutterChangeDelete  term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#1d2021 guifg=#427b58

nnoremap <silent><Leader>gg :GitGutterSignsToggle<CR>
