"
" disable YCM diagnostics
"
let g:ycm_show_diagnostics_ui=0
let g:ycm_echo_current_diagnostic=0
let g:ycm_enable_diagnostic_signs=0
let g:ycm_enable_diagnostic_highlighting=0
let g:ycm_min_num_of_chars_for_completion=3

"
" completion rules
"
let g:ycm_complete_in_strings=1
let g:ycm_complete_in_comments=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_collect_identifiers_from_comments_and_strings=1

"
" use supertab for navigation
"
let g:ycm_key_list_select_completion=['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-k>', '<C-p>', '<Up>']

"
" Source navigation
"
" nnoremap <silent><Leader>0 :YcmCompleter GoToInclude<CR>
" nnoremap <silent><Leader>1 :YcmCompleter GoToDeclaration<CR>
" nnoremap <silent><Leader>2 :YcmCompleter GoToDefinition<CR>
" nnoremap <silent><Leader>3 :YcmCompleter GoToImplementation<CR>
" nnoremap <silent><Leader>4 :YcmCompleter GoToReferences<CR>
