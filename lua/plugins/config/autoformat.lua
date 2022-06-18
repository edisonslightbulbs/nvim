vim.cmd [[
"
" formatter paths
"
if has('win32')
let g:formatterpath = ['$HOME\AppData\Roaming\npm\', '$HOME\go\bin\',
            \ 'C:\ProgramData\chocolatey\bin\',
            \ 'C:\Users\zoemthun\AppData\Local\Programs\Python\Python39\Scripts\',
            \ 'C:\Users\zoemthun\AppData\Local\Programs\Python\Python38\Scripts\',
            \ 'C:\Users\zoemthun\AppData\Local\Programs\Python\Python37-32\Scripts\']
else
endif

"
" python formatter
"
" let g:formatdef_autopep8 = '"autopep8 --in-place --aggressive --aggressive -".(g:DoesRangeEqualBuffer(a:firstline, a:lastline) ? " --range ".a:firstline." ".a:lastline : "")." ".(&textwidth ? "--max-line-length=".&textwidth : "")'
" let g:formatters_autopep8 = ['autopep8']

"
" cxx formatter
"
let g:formatdef_cmake_format = '"cmake-format - --tab-size ".shiftwidth()." ".(&textwidth ? "--line-width=".&textwidth : "")'
let g:formatters_cmake = ['cmake_format']

"
" cmake formatter
"
let g:formatdef_clangformat = '"clang-format"'
let g:formatters_cpp = ['clangformat']

"
" sh formatter
"
let g:formatdef_sh='"shfmt"'
let g:formatters_sh=['sh']

"
" zsh formatter
"
let g:formatdef_zsh='"shfmt"'
let g:formatters_zsh=['zsh']

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
    execute ':retab!'
    execute ':Autoformat'
endfunction

nnoremap <Leader>i :call Retab()<CR>
]]
