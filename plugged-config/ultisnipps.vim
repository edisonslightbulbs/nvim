let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<C-J>'
let g:UltiSnipsJumpBackwardTrigger='<C-K>'
let g:UltiSnipsSnippetDirectories=['ultisnipps']
let g:UltiSnipsSnippetsDir='$HOME/.config/nvim/ultisnipps'

if has('win32')
    let g:UltiSnipsSnippetsDir='$HOME\AppData\Local\nvim\ultisnipps'
else
endif
