-- table for git functions and variables
_G.config.git = {}

-- find top-level .git directory
config.git.root = function()
  local path = vim.fn.expand('%:p:h')
  while path ~= '/' do
    local gitdir = path..'/.git'
    if vim.fn.isdirectory(gitdir) == 1 then
      return path
    end
    path = vim.fn.fnamemodify(path, ':h')
  end
  return vim.fn.expand('%:p:h')
end
