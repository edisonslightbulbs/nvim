if vim.fn.has('unix') then
    vim.g.python3_host_prog = '/usr/bin/python3.8'
    vim.g.python_host_prog = '/usr/bin/python'
elseif vim.fn.has('win32') then
    vim.g.python3_host_prog = 'C:\\Users\\zoemthun\\AppData\\Local\\Programs\\Python\\Python37-32\\python.exe'
    vim.g.python_host_prog = 'C:\\Users\\zoemthun\\AppData\\Local\\Microsoft\\WindowsApps\\python.exe'
    vim.g.ruby_host_prog = 'C:\\Ruby30-x64\\bin\\ruby.exe'
end
