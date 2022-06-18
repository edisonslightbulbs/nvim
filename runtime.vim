"
" runtime path
"
" if has('win32')
"     set runtimepath^=$nvim_path runtimepath+=$nvim_path\after
" else
"     set runtimepath^=$nvim_path runtimepath+=$nvim_path/after
" endif
" let &packpath=&runtimepath

"
" host program paths
"
if has('win32')
    let g:python3_host_prog='$HOME\AppData\Local\Programs\Python\Python37-32\python.exe'
    let g:python_host_prog='$HOME\AppData\Local\Microsoft\WindowsApps\python.exe'
    let g:ruby_host_prog = 'C:\Ruby30-x64\bin\ruby.exe'
else
    let g:python3_host_prog='/usr/bin/python3.8'
    let g:python_host_prog='/usr/bin/python'
endif

"
" vimplug
"
" if has('win32')
"     if empty(glob($plug_win32))
"         silent execute '!curl -fLo ' . $nvim_path . '\autoload\plug.vim --create-dirs ' .
"                     \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"     endif
" else
"     if empty(glob($plug_unix))
"         silent execute  '!curl -fLo ' .  $nvim_path . '/autoload/plug.vim --create-dirs ' .
"                     \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"     endif
" endif
