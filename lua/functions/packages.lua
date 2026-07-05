-- table for package functions and variables
_G.config.packages = {}

config.packages.update = function()
    local answer = vim.fn.confirm(
        'Update Neovim plugins, tools, and parsers, then quit?',
        '&Yes\n&No',
        2
    )

    if answer ~= 1 then
        return
    end

    vim.cmd('wall')

    require('lazy').sync({ wait = true })

    vim.cmd('MasonToolsUpdateSync')
    vim.cmd('TSUpdateSync')

    vim.cmd('qall')
end
