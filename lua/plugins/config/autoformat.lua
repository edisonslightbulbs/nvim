vim.cmd [[
"
" formatter paths
"
if has('win32')
    let g:formatterpath = ['C:\Users\zoemthun\go\bin\',
    \ 'C:\ProgramData\chocolatey\bin\',
    \ 'C:\Users\zoemthun\AppData\Roaming\npm\',
    \ 'C:\Users\zoemthun\AppData\Roaming\Python\Python39\Scripts\',
    \ 'C:\Users\zoemthun\AppData\Roaming\Python\Python38\Scripts\']
else
endif

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
" latex formatter
"
"let g:formatdef_latexindent = '"latexindent -"'

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
