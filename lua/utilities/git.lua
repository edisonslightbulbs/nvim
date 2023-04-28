-- table for git functions and variables
_G.config.git = {}

-- find top-level .git directory
config.git.root = function()
  local path = vim.fn.expand('%:p:h')
  local counter = 0

  while counter < 5 do
    local gitdir = path..'/.git'
    if vim.fn.isdirectory(gitdir) == 1 then
      return path
    end
    path = vim.fn.fnamemodify(path, ':h')
    counter = counter + 1
  end
  return vim.fn.expand('%:p:h')
end
