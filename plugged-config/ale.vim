" " scriptencoding for multibyte chars
" set encoding=utf-8
" scriptencoding utf-8
"
" let g:ale_sign_column_always=0
" let g:ale_set_loclist=0
" let g:ale_set_quickfix=1
" let g:ale_set_balloons=1
"
" let g:ale_sign_info=''
" let g:ale_sign_error=''
" let g:ale_sign_style_error=''
" let g:ale_sign_warning=''
" let g:ale_sign_style_warning=''
" let g:ale_echo_msg_error_str='Error'
" let g:ale_echo_msg_warning_str='Warning'
" let g:ale_echo_msg_format='[%severity%] [%linter%] %s'
"
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_autoclose_preview_window_after_completion = 1
"
" augroup for_zsh_File
"     autocmd!
"     autocmd FileType zsh let g:ale_sh_shell_default_shell='zsh'
" augroup END
"
" " LINTERS:
" let g:ale_linters={
"             \'c': ['clangtidy'],
"             \'cpp': ['clangtidy']}
"
" " FIXERS:
" let g:ale_fixers={
"             \'cpp': ['clangtidy'],
"             \'*': ['remove_trailing_lines', 'trim_whitespace']}
" let g:ale_cpp_clangtidy_fix_errors=1
"
" " CMAKE:
" let g:ale_cmake_cmakelint_executable='cmakelint'
" let g:ale_cmake_cmakelint_options=''
" let g:ale_cmake_cmakeformat_executable='cmake-format'
" let g:ale_cmake_cmakeformat_options=''
"
" " CXX:
" " -- CAVEAT: in CMakeLists.text, put set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
" " let g:ale_c_parse_makefile=1
" " let g:ale_c_parse_compile_commands=1
"
" " let g:ale_cpp_parse_makefile=1
" " let g:ale_cpp_parse_compile_commands=1
"
" let g:ale_cpp_clangtidy_executable='clang-tidy'
" let g:ale_cpp_clangtidy_options='-Wall -std=c++14 -x c++  -I /usr/include/eigen3 -I$HOME/Repositories/research/projects/sap/include'
" let g:ale_cpp_clangtidy_checks = ['-*', 'cppcoreguidelines-*']
"
" " let g:ale_cpp_clangtidy_checks=[
"             "\'-*'
"             "\'mpi-*',
"             "\'hicpp-*',
"             "\'boost-*',
"             "\'abseil-*',
"             "\'openmp-*',
"             "\'bugprone-*',
"             "\'readability-*',
"             "\'portability-*',
"             "\'performance-*',
"             "\'cert-cert-dcl03-c',
"             "\'cert-cert-dcl21-cpp',
"             "\'cert-cert-dcl58-cpp',
"             "\'cert-cert-err34-c',
"             "\'cert-cert-err52-cpp',
"             "\'cert-cert-err58-cpp',
"             "\'cert-cert-err60-cpp',
"             "\'cert-cert-flp30-c',
"             "\'cert-cert-msc50-cpp',
"             "\'cert-cert-msc51-cpp',
"             "\'cert-cert-gop54-cpp',
"             "\'modernize-modernize-use-auto',
"             "\'modernize-modernize-avoid-bind',
"             "\'modernize-modernize-make-shared',
"             "\'modernize-modernize-make-unique',
"             "\'modernize-modernize-use-emplace',
"             "\'modernize-modernize-use-nullptr',
"             "\'modernize-modernize-use-override',
"             "\'modernize-modernize-use-noexcept',
"             "\'modernize-modernize-loop-convert',
"             "\'modernize-modernize-pass-by-value',
"             "\'modernize-modernize-use-nodiscard',
"             "\'modernize-modernize-shrink-to-fit',
"             "\'modernize-modernize-replace-auto-ptr',
"             "\'modernize-modernize-use-equals-delete',
"             "\'modernize-modernize-use-bool-literals',
"             "\'modernize-modernize-use-equals-default',
"             "\'modernize-modernize-raw-string-literal',
"             "\'modernize-modernize-redundant-void-arg',
"             "\'modernize-modernize-deprecated-headers',
"             "\'modernize-modernize-unary-static-assert',
"             "\'modernize-modernize-replace-random-shuffle',
"             "\'modernize-modernize-return-braced-init-list',
"             "\'modernize-modernize-use-uncaught-exceptions',
"             "\'modernize-modernize-use-transparent-functors',
"             "\'modernize-modernize-concat-nested-namespaces',
"             "\'modernize-modernize-deprecated-ios-base-aliases',
"             "\'hicpp-hicpp-signed-bitwise',
"             "\'hicpp-hicpp-exception-baseclass',
"             "\'hicpp-hicpp-multiway-paths-covered',
"             "\'google-google-runtime-operator',
"             "\'google-google-default-arguments',
"             "\'google-google-explicit-constructor',
"             "\'misc-misc-static-assert',
"             "\'misc-misc-misplaced-const',
"             "\'misc-misc-new-delete-overloads',
"             "\'misc-misc-non-copyable-objects',
"             "\'misc-misc-redundant-expression',
"             "\'misc-misc-uniqueptr-reset-release',
"             "\'misc-misc-throw-by-value-catch-by-reference',
"             "\'misc-misc-unconventional-assign-operator',
"             "\'cppcoreguidelines-cppcoreguidelines-slicing',
"             "\'cppcoreguidelines-cppcoreguidelines-pro-type-member-init',
"             "\'cppcoreguidelines-cppcoreguidelines-narrowing-conversions',
"             "\'cppcoreguidelines-cppcoreguidelines-interfaces-global-init',
"             "\'cppcoreguidelines-cppcoreguidelines-pro-type-static-cast-downcast',
"             "\]
"
" " SHELL:
" let g:ale_sh_bashate_executable = ''
" let g:ale_sh_bashate_options = ''
" let g:ale_sh_language_server_executable = ''
" let g:ale_sh_shellcheck_executable='shellcheck'
" "let g:ale_sh_shellcheck_options='-a -x -C=always -enable=all –shell=shell –severity=style' <--- buggy
" let g:ale_sh_shellcheck_options='-a -x'
" let g:ale_sh_shellcheck_change_directory=1
" let g:ale_sh_shellcheck_dialect='auto'
"
" " VIM:
" " -- vim-language-server
" let g:ale_vim_vimls_use_global=1
" let g:ale_vim_vimls_config={
"             \'initializationOptions': {
"             \
"             \    'iskeyword': '@,48-57,_,192-255,-#',
"             \    'vimruntime': '',
"             \    'runtimepath': '',
"             \    'diagnostic': {'enable': v:true},
"             \
"             \    'indexes': {
"             \        'runtimepath': v:true,
"             \        'gap': 100,
"             \        'count': 3,
"             \        'projectRootPatterns' : ['strange-root-pattern', '.git', 'autoload', 'plugin']
"             \    },
"             \
"             \    'suggest': {
"             \      'fromVimruntime': v:true,
"             \      'fromRuntimepath': v:false
"             \    },
"             \
"             \    'filetypes': [ 'vim' ]}
"             \}
"
" " -- vint
" let g:ale_vim_vint_executable='vint'
" let g:ale_vim_vint_show_style_issues=1
"
" " HIGHLIGHTS:
" let g:ale_set_signs=1
" let g:ale_set_highlights=1
" let g:ale_change_sign_column_color=1
"
" highlight ALESignColumnWithErrors    term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#1d2021 guifg=NONE
" highlight ALESignColumnWithoutErrors term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#1d2021 guifg=NONE
"
" highlight ALEWarning                 term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guifg=#076678
" highlight ALEWarningSign             term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#1d2021 guifg=#076678
" highlight ALEWarningLine             term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#21262c guifg=NONE
" highlight ALEWarningSignLineNr       term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#076678 guifg=#076678
"
" highlight ALEError                   term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guifg=#fb4934
" highlight ALEErrorSign               term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#1d2021 guifg=#fb4934
" highlight ALEErrorLine               term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#21262c guifg=NONE
" highlight ALEErrorSignLineNr         term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#fb4934 guifg=#fb4934
"
" highlight ALEInfo                    term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guifg=Grey
" highlight ALEInfoSign                term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#1d2021 guifg=Grey
" highlight ALEInfoLine                term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=#21262c guifg=NONE
" highlight ALEInfoSignLineNr          term=bold cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=Grey guifg=Grey
"
" nmap <silent><Leader>5 <Plug>(ale_next_wrap)
