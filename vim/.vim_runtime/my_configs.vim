set nocompatible " this is redundant


"" =========vim-polyglot config=======
let g:polyglot_disabled = ['ftdetect', 'r-lang', 'v', 'verilog']
"" ===================================






""  ******* vim-plug config *****************
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
call plug#begin('~/.vim_runtime/plugged')

"" Language Server for vim-lsp 
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

"" ===== ddc.vim plugins ==========
Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'

"" Install your UIs
Plug 'Shougo/ddc-ui-native'
Plug 'Shougo/ddc-ui-pum'
Plug 'Shougo/pum.vim'

"" Install your sources
Plug 'shun/ddc-source-vim-lsp'
" Plug 'Shougo/ddc-source-lsp'
Plug 'Shougo/ddc-source-around'

"" Install your filters
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'
Plug 'tani/ddc-fuzzy'
"" ================================

"" Lightline
Plug 'itchyny/lightline.vim'
Plug 'halkn/lightline-lsp'
Plug 'mengelbrecht/lightline-bufferline'

"" Colorschemes
Plug 'sainnhe/sonokai'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" Plug 'ku1ik/vim-monokai'

"" Theorem Provers
Plug 'whonore/Coqtail'
Plug 'tamarin-prover/editors'

"" Latex notetaking
Plug 'lervag/vimtex'
"Plug 'gi1242/vim-tex-syntax'
Plug 'sirver/ultisnips' " snippets

"" Local .vimrc
Plug 'embear/vim-localvimrc'

"" Language Packs
Plug 'sheerun/vim-polyglot'
Plug 'bfrg/vim-cpp-modern' " c/c++ highlighting
Plug 'uiiaoo/java-syntax.vim' " java highlighting
Plug 'elzr/vim-json'
Plug 'preservim/vim-markdown' " markdown highlighting
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

"" Others
Plug 'rlue/vim-barbaric'
Plug 'RRethy/vim-hexokinase'
Plug 'lambdalisue/vim-fern' " file tree viewer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

""  ****************************************
        











"" =========ddc config================
" Customize global settings:
call ddc#custom#patch_global('ui', 'native')
"call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global({
    \'sources': ['vim-lsp', 'around'],
    \'sourceOptions': {
        \'_': {
            \'matchers': ['matcher_fuzzy'],
            \'sorters': ['sorter_fuzzy'],
            \'converters': ['converter_fuzzy']
        \},
        \'around': {
            \'mark': 'A'
        \},
        \'vim-lsp': {
            \'mark': 'lsp'
        \}
    \},
    \'sourceParams': {
        \'around': {
            \'maxSize': 300 
        \},
        \'vim-lsp': {
            \'ignoreCompleteProvider': v:true,
            \'dup': v:true
        \}
    \}   
\})

" pum (Shougo/pum.vim) configuration:
"inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
"inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
"inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
"inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
"inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
"inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>

" Prevent autocompletion menu being refreshed due to <Down> triggering TextChangedP event:
set completeopt=menu,menuone,noinsert,noselect
set completeopt-=preview   " optional: avoid preview-window churn

" Use matcher_head and sorter_rank:
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
"call ddc#custom#patch_global('sourceOptions', #{
"      \   _: #{
"      \     matchers: ['matcher_head'],
"      \     sorters: ['sorter_rank']},
"      \   },
"      \ )
      

" Customize settings on a filetype:
"call ddc#custom#patch_filetype(
"    \   ['c', 'cpp'], 'sources', ['clangd']
"    \ )
"call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', #{
"    \   clangd: #{ mark: 'C' },
"    \ })
call ddc#custom#patch_filetype('markdown', 'sourceParams', #{
    \   around: #{ maxSize: 100 },
    \ })


" Mappings: 

" <TAB>: completion.
" NOTE: It does not work for pum.vim
"inoremap <expr> <TAB>
"\ pumvisible() ? '<C-n>' :
"\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
" NOTE: It does not work for pum.vim
"inoremap <expr> <S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc:
call ddc#enable()
"" =======================================

"" =========vim-lsp config================
let g:lsp_diagnostics_enabled = 1         " show errors/warnings from linter
let g:lsp_diagnostics_echo_cursor = 1 " Echo warning/error under cursor in normal mode
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0
let g:lsp_diagnostics_signs_enabled = 0

" Prettier gutter signs
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_document_code_action_signs_enabled = 0

" Lets you see the hover information (e.g. type) by pressing Ctrl+Q
inoremap <silent> <C-q> <Esc>:LspHover<CR>i
noremap <silent> <C-q> :LspHover<CR>
" Use tag muscle memory to go to definition, press Ctrl+D
inoremap <silent> <C-d> <Esc>:LspDefinition<CR>i
noremap <silent> <C-d> :LspDefinition<CR>

" highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green
let g:lsp_document_highlight_enabled = 1
let g:lsp_log_file = expand('~/vim-lsp.log') " for debugging

"" =======================================

"" =========vim-lsp-settings config=======
" If pylsp is managed by vim-lsp-settings:
" pylsp's venv config file is at: ~/.local/share/vim-lsp-settings/servers/pylsp-all/venv/pyvenv.cfg
" Remember to pip install: python-lsp-ruff, pylsp-mypy
"   after reinstalling pylsp-all

" If pylsp is managed by pacman:
" To install python-lsp-ruff and pylsp-mypy, run: yay -S python-lsp-ruff pylsp-mypy


" TODO: replace mypy with pylyzer for type checking (maybe complicated or even unfeasible)

let g:lsp_settings_filetype_python = 'pylsp'

let g:lsp_settings = {
\   'ocaml-lsp': {
\     'cmd': [&shell, &shellcmdflag, 'opam exec -- ocamllsp'] 
\   },
\   'clangd': {
\     'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cuda', 'yacc', 'lex']
\   },
\   'pylsp': {
\     'cmd': ['pylsp'],
\     'workspace_config': {
\       'pylsp': {
\         'plugins':{
\           'ruff': {
\               'enabled': v:true,
\               'formatEnabled': v:true
\           },
\           'pylsp_mypy': {
\               'enabled': v:true,
\               'live_mode': v:true,
\               'strict': v:false,
\               'report_progress': v:false
\           },
\           'pycodestyle': {'enabled': v:false},
\           'jedi_completion':{
\             'include_class_objects': v:true,
\             'include_function_objects': v:true,
\             'fuzzy': v:true
\           }
\         }
\       }
\     }
\   }
\}
"" =======================================


"" ========= lightline =======================
" to show buffers instead of tabs in the tabline, change 'tabs' to 'buffers'
let g:lightline = {
      \ 'tabline': {
      \   'left': [['tabs']],
      \   'right': [['close']]
      \ },
      \ 'tab': {
	  \   'active': [ 'tabnum', 'relpath', 'modified' ],
	  \   'inactive': [ 'tabnum', 'relpath', 'modified' ] 
      \ },
      \ 'tab_component_function': {
      \   'relpath': 'LightlineRelPath'
      \ },
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['gitbranch', 'readonly', 'relativepath', 'modified'] ],
      \   'right': [ [ 'lsp_errors', 'lsp_warnings', 'lsp_ok', 'lineinfo' ],
      \              [ 'filetype', 'percent' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'gitbranch': '%{(exists("*FugitiveHead") && FugitiveHead() !=# "")?" ".FugitiveHead():""}'
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \   'lsp_warnings': 'lightline_lsp#warnings',
      \   'lsp_errors':   'lightline_lsp#errors',
      \   'lsp_ok':       'lightline_lsp#ok',
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel',
      \   'lsp_warnings': 'warning',
      \   'lsp_errors':   'error',
      \   'lsp_ok':       'right',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'gitbranch': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightlineRelPath(n) abort
  let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let name = bufname(bufnr)
  return empty(name) ? '[No Name]' : pathshorten(fnamemodify(name, ':.'))
endfunction

let g:lightline_lsp_signs_ok = ''
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#number_separator = ' '
set showtabline=2
"" ==============================================




"" ========= colorscheme =======================
" Important!!
if has('termguicolors')
    set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'andromeda' " perhaps 'atlantis'. i cant really tell the diff b/w the two
let g:sonokai_better_performance = 1
let g:sonokai_transparent_background = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnostic_line_highlight = 0
let g:sonokai_diagnostic_virtual_text = 'highlighted'
let g:sonokai_lightline_disable_bold = 0
let g:lightline.colorscheme = 'sonokai' 

colorscheme sonokai

" This line needs to go below 'colorscheme'
" Link a highlight group to a predefined highlight group.
" See `colors/sonokai.vim` for all predefined highlight groups.
"hi Normal guibg=NONE ctermbg=NONE
hi! link Conceal Green
let s:palette = sonokai#get_palette(g:sonokai_style, {})
call sonokai#highlight('SpecialKey', s:palette.grey, s:palette.none) " grey_dim is also nice-looking
" some 'SpecialKey' for color checking -> 
"" ==============================================


"" =========vim-hexokinase config================
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
" which patterns are matched
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
" which filetypes to scrape automatically
"let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript'] 
"" ==============================================


"" =========vim-cpp-modern config================
" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 0
"" ==============================================


"" =========vim-markdown config==================
" let g:markdown_fenced_languages = ['html', 'python', 'vim', 'css', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml']
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_frontmatter = 1
" let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
"" ==============================================


"" =========java-syntax.vim config===============
highlight link javaIdentifier NONE
"" ==============================================


"" =========vimtex config========================
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
"" ==============================================


"" =========fzf config===========================
let g:fzf_vim = {} " Initialize configuration dictionary
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
"" ==============================================

"" =========ultisnips config=====================
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"" ==============================================


"" ========= fold and conceal ===================
" fold
set foldcolumn=0
set foldmethod=syntax 
set foldnestmax=1

" conceal
set conceallevel=2

" copied from: https://alok.github.io/2018/04/26/using-vim-s-conceal-to-make-languages-more-tolerable/
function! ToggleConcealLevel()
    if &conceallevel == 0
        setlocal conceallevel=2
    else
        setlocal conceallevel=0
    endif
endfunction
nnoremap <silent> <C-c><C-y> :call ToggleConcealLevel()<CR>
"" ==============================================


"" ========= keybinds ===========================
" Remap the enter key to ctrl-y in 'insert mode' only when the pop-up menu is visible. Thus still allowing for normal behavior when the pop-up menu is not visible.
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" add cut, copy, and paste keybinds
" commands from https://superuser.com/questions/10588/how-to-make-cut-copy-paste-in-gvim-on-ubuntu-work-with-ctrlx-ctrlc-ctrlv/189198#189198
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" go to next/previous line in insert mode and normal mode
set whichwrap+=<,>,h,l,b,[,]

" Go to buffer by ordinal number, <leader> is ','
"nmap <leader>1 <Plug>lightline#bufferline#go(1)
"nmap <leader>2 <Plug>lightline#bufferline#go(2)
"nmap <leader>3 <Plug>lightline#bufferline#go(3)
"nmap <leader>4 <Plug>lightline#bufferline#go(4)
"nmap <leader>5 <Plug>lightline#bufferline#go(5)
"nmap <leader>6 <Plug>lightline#bufferline#go(6)
"nmap <leader>7 <Plug>lightline#bufferline#go(7)
"nmap <leader>8 <Plug>lightline#bufferline#go(8)
"nmap <leader>9 <Plug>lightline#bufferline#go(9)
"nmap <leader>0 <Plug>lightline#bufferline#go(10)
"nmap <Tab>   <Plug>lightline#bufferline#go_next()
"nmap <S-Tab> <Plug>lightline#bufferline#go_previous()
"nmap <leader><Tab>   <Plug>lightline#bufferline#go_next_category()
"nmap <leader><S-Tab> <Plug>lightline#bufferline#go_previous_category()
" Delete buffer by ordinal number, <leader> is ','
"nmap <leader>c1 <Plug>lightline#bufferline#delete(1)
"nmap <leader>c2 <Plug>lightline#bufferline#delete(2)
"nmap <leader>c3 <Plug>lightline#bufferline#delete(3)
"nmap <leader>c4 <Plug>lightline#bufferline#delete(4)
"nmap <leader>c5 <Plug>lightline#bufferline#delete(5)
"nmap <leader>c6 <Plug>lightline#bufferline#delete(6)
"nmap <leader>c7 <Plug>lightline#bufferline#delete(7)
"nmap <leader>c8 <Plug>lightline#bufferline#delete(8)
"nmap <leader>c9 <Plug>lightline#bufferline#delete(9)
"nmap <leader>c0 <Plug>lightline#bufferline#delete(10)

" Go to tab by number, <leader> is ','
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
"" ==============================================




"" =========other settings================
"filetype plugin indent on
"syntax enable
set mouse=a
set number relativenumber




"" indent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab


" displays your keystrokes in statusline as you enter them
set showcmd

" stop vim from adding a newline at end of file
set nofixendofline

" man page
runtime! ftplugin/man.vim

"" python with virtualenv support
" (not set yet)

"" =======================================
