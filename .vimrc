set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
" tab 相关
set ts=4
set sw=4
set sts=4
set tw=80
set re=0
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set hls
set autoindent
set smarttab

set autochdir
set autoread
set autowrite
set noswapfile
set nowritebackup
set nowrapscan
set foldmethod=manual
set foldtext=gitgutter#fold#foldtext()
filetype indent on "根据文件类型进行缩进"
filetype on
filetype plugin indent on

set nu
set cursorline
set showmatch
set syntax=enable
set guifont=FiraCode
set incsearch
set updatetime=100
set signcolumn=auto
set undofile
set undodir=~/.vim/undodir


" set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1

set nocompatible

" 插件设置
set statusline+=%{gutentags#statusline()}

" Rg 指定路径
command! -bang -nargs=* Rg2
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}), <bang>0)
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "tokyonight"

let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

" "LeaderF
" let g:Lf_ShortcutF = '<c-p>'     "ctrl+p 搜索文件
" let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }  "搜索框位置
" let g:Lf_RootMarkers = ['.project']   "顶层目录的标记名称，文件搜索，字符串搜索，gtags搜搜都从标记位置开始
" let g:Lf_WorkingDirectoryMode = 'Ac'  "搜索时显示相对目录
" let g:Lf_WindowHeight = 0.30      "搜索窗口高度
" let g:Lf_CacheDirectory = expand('~/.vim/cache')  "LeaderF会自动管理GTAGS，自动生成的cache存放目录
" let g:Lf_ShowRelativePath = 0      
" let g:Lf_HideHelp = 1      "隐藏帮助窗口
" let g:Lf_GtagsAutoGenerate = 1   "自动生成GTAGS文件
" 自动作者信息
"
augroup author
	autocmd BufNewFile *.cpp,*.h,*.c,*.go,*.php exec ":call SetTitle()"
augroup end

func SetTitle()
	if &filetype == 'php'
		call setline(1,"/**")
		call append(line("."), "* File Name: ".expand("%"))
		call append(line(".")+1, "* ")
		call append(line(".")+2, "* @author guohaoran(@baidu.com)")
		call append(line(".")+3, "* @date ".strftime("%Y-%m-%d"))
		call append(line(".")+4, "**/")
	endif
	if &filetype == 'go'
		call append(line("."), "\// Package ...")
		call append(line(".")+1, "\// @Description ")
		call append(line(".")+2, "\// @Author guohaoran@baidu.com")
		call append(line(".")+3, "\// @Date ".strftime("%Y-%m-%d"))
	endif
	if &filetype == 'cpp'
		call setline(1,"/**")
		call append(line("."), "* @file ".expand("%"))
		call append(line(".")+1, "* @author guohaoran(@baidu.com)")
		call append(line(".")+2, "* @date ".strftime("%Y-%m-%d"))
		call append(line(".")+3, "**/")
	endif
	if &filetype == 'c'
		call setline(1,"/**")
		call append(line("."), "* @file ".expand("%"))
		call append(line(".")+1, "* @author guohaoran(@baidu.com)")
		call append(line(".")+2, "* @date ".strftime("%Y-%m-%d"))
		call append(line(".")+3, "**/")
	endif
	if &filetype == 'h'
		call setline(1,"/**")
		call append(line("."), "* @file ".expand("%"))
		call append(line(".")+1, "* @author guohaoran(@baidu.com)")
		call append(line(".")+2, "* @date ".strftime("%Y-%m-%d"))
		call append(line(".")+3, "**/")
	endif
endfunc

" 快捷键映射
nnoremap <space> <Nop>
let mapleader = " "
nnoremap <leader> <C-W>
nnoremap <silent> <leader><Tab> :NERDTreeToggle<CR>
nnoremap <C-u> :TagbarToggle<CR>
nnoremap <F12> :RainbowParenthesesToggle<cr>:RainbowParenthesesLoadBraces<cr>
tnoremap jk <esc>
cnoremap jk <esc>
inoremap jk <esc>

" tnoremap <Esc> <C-w>N
nnoremap <c-h> :bp<cr>
nnoremap <c-l> :bn<cr>
" coc 配置
function! CheckBackspace() abort
	let col = col('.') -1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <leader>o coc#refresh()
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
nnoremap <silent> <leader>0 :call AddWorkspaceFolder()<CR>
nnoremap <silent> <leader>1 :call AddWorkspaceFolder1()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! AddWorkspaceFolder()
    call CocAction('addWorkspaceFolder','/home/work/yong/yc')
    execute 'CocCommand intelephense.index.workspace'
endfunction

function! AddWorkspaceFolder1()
    call CocAction('addWorkspaceFolder','/home/work/code/baidu/map-bus-kuaixing')
    execute 'CocCommand intelephense.index.workspace'
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>qf <Plug>(coc-fix-current)

let g:NERDTreeHidden=0
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
call plug#begin('~/.vim/plugged')

Plug 'ghifarit53/tokyonight-vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'mhinz/vim-startify'
Plug 'preservim/tagbar'
Plug 'preservim/nerdcommenter'
Plug 'morhetz/gruvbox'
Plug 'StanAngeloff/php.vim'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries' }
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-airline/vim-airline'
Plug 'prabirshrestha/vim-lsp'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'buoto/gotests-vim'
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
" Plug 'Yggdroot/indentLine'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
" Plug 'Yggdroot/LeaderF'
Plug 'goerz/jupytext.vim'



call plug#end()

let g:gotests_bin = '/home/work/go/bin/gotests'

let g:go_debug = ['dlv']
let g:go_auto_type_info = 1
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 0

let g:cpp_class_decl_highlight=1
let g:cpp_class_scope_highlight = 1
let g:cpp_concepts_highlight = 1
let g:lsp_cxx_hl_use_text_props = 1

let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" let g:indent_guides_guide_size = 1
" let g:indent_guides_start_level = 2

let php_var_selector_is_identifier = 1
let g:rbpt_max=16
let g:rbpt_loadcmd_toggle=0

let g:solarized_termcolors=256
let g:solarized_termtrans = 1
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1 

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
let g:gutentags_enabled = 1
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

colorscheme tokyonight
let g:lightline = {'colorscheme' : 'tokyonight'}
let g:airline_theme = "tokyonight"
" colorscheme solarized
" let g:lightline = {'colorscheme':'solarized'}
" let g:airline_theme = "solarized"
" set background=light

let g:NERDSpaceDelims = 1
let g:gitgutter_set_sign_backgrounds = 1
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_grep = 'rg'
iunmap <Leader>o
