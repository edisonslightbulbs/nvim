vim.g.airline_detect_paste = 0
vim.g.airline_detect_crypt = 1
vim.g.airline_detect_spell = 0
vim.g.airline_detect_modified = 1
vim.g.airline_powerline_fonts = 1

vim.g['airline#extensions#tabline#enabled'] = 1

vim.g.airline_inactive_collapse = 0
vim.g.airline_section_c = '%-0.100{getcwd()}'

vim.g['airline#extensions#tabline#left_sep'] = ''
vim.g['airline#extensions#tabline#left_alt_sep'] = ''
vim.cmd([[ let g:airline#extensions#branch#vcs_checks  =  [] ]])

vim.g.airline_theme = 'jellybeans'

vim.g.airline_left_sep = ''
vim.g.airline_right_sep = ''
