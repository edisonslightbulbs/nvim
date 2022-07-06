vim.cmd [[
"
" cxx formatter
"
let g:formatdef_cmake = '"cmake-format - --tab-size ".shiftwidth()." ".(&textwidth ? "--line-width=".&textwidth : "")'
let g:formatters_cmake = ['cmake']

"
" cmake formatter
"
let g:formatdef_clang = '"clang-format"'
let g:formatters_clang = ['clang']

"
" sh formatter
"
let g:formatdef_sh='"shfmt"'
let g:formatters_sh=['sh']

"
" verbose troubleshooting
"
let g:autoformat_verbosemode=1

"
" keybinds
"
function! Retab()
    let l:view = winsaveview()
    execute ':retab!'
    execute ':Autoformat'
    call winrestview(l:view)
endfunction

nnoremap <Leader>i :call Retab()<CR>
]]
