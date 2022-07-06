vim.cmd [[
if has('win32')
    let g:python3_host_prog = 'C:\Users\zoemthun\AppData\Local\Programs\Python\Python37-32\python.exe'
    let g:python_host_prog = 'C:\Users\zoemthun\AppData\Local\Microsoft\WindowsApps\python.exe'
    let g:ruby_host_prog = 'C:\Ruby30-x64\bin\ruby.exe'

    "
    " formatter paths
    "
    let g:formatterpath = [
    \ 'C:\Users\zoemthun\go\bin\',
    \ 'C:\ProgramData\chocolatey\bin\',
    \ 'C:\Users\zoemthun\AppData\Roaming\npm\',
    \ 'C:\Users\zoemthun\AppData\Roaming\Python\Python39\Scripts\',
    \ 'C:\Users\zoemthun\AppData\Roaming\Python\Python38\Scripts\']
else
    let g:python3_host_prog='/usr/bin/python3.8'
    let g:python_host_prog='/usr/bin/python'
endif
]]
