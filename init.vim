  "____     ___        __
 "/ ___|   | \ \      / /
"| |  _ _  | |\ \ /\ / /
"| |_| | |_| | \ V  V /
 "\____|\___/   \_/\_/

"general settings
" Enable the true color
"if (has("termguicolors"))
 "set termguicolors
"endif
set termguicolors	" enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"设置如何分词
set iskeyword +=-
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  
set fileencoding=utf-8
set nopaste
" keep 3 lines when scrolling"
set scrolloff=3
set shiftround

" 设置当文件被改动时自动载入
set autoread
"共享剪贴板  
""set clipboard+=unnamed 
set clipboard=unnamed 
"自动保存
set autowrite
set ruler                   " 打开状态栏标尺
set cursorline              " 突出显示当前行
set magic                   " 设置魔术
" 自动缩进
"set autoindent
"为c和java提供缩进
"set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不要用空格代替制表符
"set noexpandtab
"使用空格代替制表符
set expandtab
" 在行和段开始处使用制表符
"set smarttab
" 显示行号
set number
set relativenumber
" 历史记录数
set history=1000
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase
set smartcase
"搜索逐字符高亮
set hlsearch
set incsearch
" 字符间插入的像素行数目
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set ttyfast "should make scrolling faster
set lazyredraw "same as above

"mapping settings
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "

" === Cursor Movement
" Use <space> + new arrow keys for moving the cursor around windows
map <LEADER>w <C-w>w
map <LEADER>k <C-w>k
map <LEADER>j <C-w>j
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l
map <LEADER>r <C-w>r

noremap <silent> J 5j
noremap <silent> K 5k

map sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map sj :set splitbelow<CR>:split<CR>
map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Opening a terminal window
map <LEADER>/ :set splitbelow<CR>:sp<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Call figlet
noremap tx :r !figlet

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h
" when open a file auto location to the position of you last time view position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""my shotcut key settings ***************************************
"map ` :!python %<CR>
" Compile function
noremap ` :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
        exec "!python3 %"
		"set splitbelow
		":sp
		":term python3 %
	elseif &filetype == 'html'
		silent exec "! open -a \"/Applications/Google Chrome.app\" % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run %
    elseif &filetype == 'javascript'
        exec "!node %"
	endif
endfunc

""set a map for esc 
inoremap jj <ESC>
"xmap jj <ESC>
""set a map for python docstring 
"inoremap ** """<space><space>"""<ESC>3hi

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
" Open Startify
noremap <LEADER>st :Startify<CR>
" Disable the default s key
"noremap s <nop>
" Remove spaces at the end of lines
nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
nnoremap Y y$
nnoremap <LEADER>b :b

" ===
" === Markdown Settings
let g:mkdp_command_for_global = 1
"" ===
" Snippets
source ~/.config/nvim/md-snippets.vim
" auto spell
"autocmd BufRead,BufNewFile *.md setlocal spell
" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

"coc.nvim will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

"neovim python provider
let g:python_host_skip_check=1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_skip_check=1
let g:python3_host_prog  = '/Users/gengjiwei/miniconda3/bin/python'

"load the plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line cu to cancle commnet
Plug 'tpope/vim-surround'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['python']}
Plug 'jpalardy/vim-slime'
Plug 'bling/vim-bufferline'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine', {'for': ['python']}
Plug 'honza/vim-snippets'
Plug 'easymotion/vim-easymotion'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ryanoasis/vim-devicons'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug', 'html'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'itchyny/lightline.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'tmhedberg/SimpylFold', {'for': ['python']}
Plug 'jaxbot/semantic-highlight.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'physicistgeng/gruvbox'
Plug 'tpope/vim-repeat'
call plug#end()
colorscheme gruvbox
"colorscheme deus
"colorscheme onedark
"colorscheme tender

syntax on           " 语法高亮  

"surround
nmap <LEADER>i ysiw

"nerdtree
"map mm :NERDTreeToggle<CR>
nmap mm :CocCommand explorer --toggle<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
"let NERDTreeIgnore=['\.pyc','\~$','\.swp', '\.__pycahe--', 'tags']
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" FZF file finder
map <c-p> :FZF
"Semshi rename
map <c-r> :Semshi rename<CR>


"plugin settings
"let g:airline_theme='base16_gruvbox_dark_hard'
"let g:airline#extensions#disable_rtp_load = 1
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#coc#enabled = 1 
"let g:airline_section_b = ''
"let g:airline#extensions#bufferline#enabled = 0

"ultisnips
"let g:UltiSnipsExpandTrigger="<c-b>"
"let g:UltiSnipsExpandTrigger=",f"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"let g:UltiSnipsJumpForwardTrigger=",f"
"let g:UltiSnipsJumpBackwardTrigger=",b"

"lightline
"let g:lightline = {
    "\ 'colorscheme': 'wombat',
    "\ }

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
	    \   'left': [ [ 'mode', 'paste' ],
	    \             [ 'readonly', 'filename', 'modified', 'cocstatus', 'cocerror' ] ]
	\ },
    \ 'component': {
    \   'lineinfo': '%3l:%-2v',
    \ },
    \ 'component_function': {
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \ },
    \ 'component_expand': {
    \   'cocstatus': 'LightLineCocStatus',
    \   'cocerror': 'LightLineCocError',
    \ },
    \ 'component_type': {
    \   'cocstatus': 'error',
    \   'cocerror': 'warning'
    \ },
    \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
    \ }

function! LightLineCocStatus()
    let msg = []
    return trim(get(g:, 'coc_status', ''))
endfunction

function! LightLineCocError()
  let error_sign = get(g:, 'coc_status_error_sign')
  let warning_sign = get(g:, 'coc_status_warning_sign')
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, error_sign . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, warning_sign . info['warning'])
  endif
  return trim(join(msgs, ' '))
endfunction
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:coc_status_error_sign = '♣ '
let g:coc_status_warning_sign = '♥ '
"===
" === coc
" ===
" fix the most annoying bug that coc has
"autocmd WinEnter * call timer_start(1000, { tid -> execute('unmap if')})
"silent! autocmd BufEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
"silent! autocmd WinEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
" use <tab> for trigger completion and navigate to the next complete item
" Installing plugins
"
"let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-json','coc-css', 'coc-tsserver', 'coc-yank', 'coc-lists', 'coc-gitignore', 'coc-translator', 'coc-pyright', 'coc-git']
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-lists', 'coc-gitignore', 'coc-lists', 'coc-git', 'coc-explorer', 'coc-pyright', 'coc-translator', 'coc-tslint']
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
" Useful commands
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap cd :CocList diagnostics<CR>
nmap cp :CocCommand python.setInterpreter<CR>
noremap ,l :sp<CR><C-w>j:term ipython --pylab<CR> i %run 
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" coc-translator
nmap ts <Plug>(coc-translator-p)
" Use K to show documentation in preview window
nnoremap <silent> D :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"coc-snippets
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = ',f'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = ',b'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap ,f <Plug>(coc-snippets-expand-jump)

"coc-git
"nmap <LEADER>g <Plug>(coc-git-chunkinfo)
nmap <leader>g :CocCommand git.chunkInfo<CR>
nmap <leader>b <plug>(coc-git-nextchunk)
nmap <LEADER>f <Plug>(coc-git-prevchunk)

"coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

"vim-slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_python_ipython = 1 


"easymotion 
nmap ss <Plug>(easymotion-s2)

"floating window for fzf
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1
			\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

"rainbow_parentheses
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"vim-rainbow
"let g:rainbow_active = 1
au FileType python,vim,markdown,java,go,sh,javascript call rainbow#load()

"tagbar
nmap tt :TagbarToggle<CR>
"devicons
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

"goyo
"map <LEADER>gy :Goyo<CR>
"let g:goyo_width=120
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!

" ===
" === Terminal Behaviors
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>

"indentLine
let g:indentLine_showFirstIndentLevel =1
let g:indentLine_fileTypeExclude=['coc-explorer']
"let g:indentLine_char='┆'

"add addtional string to specific files
autocmd BufNewFile *sh,*py,*js exec ":call SetTitle()"
func SetTitle()
	if &filetype == 'python'
		call setline(1,"#!/usr/bin/env python") 
    	call append(line("."), "# -*- coding: utf-8 -*-") 
    	call append(line(".")+1, "") 
		call append(line(".")+2, "")
    elseif &filetype == 'sh'
        call setline(1,"#!/usr/bin/env python") 
        call append(line("."), "# -*- coding: utf-8 -*-") 
    elseif &filetype == 'javascript'
        call setline(1,"'use strict'") 
        call append(line("."), "") 
    	call append(line(".")+1, "") 
    endif
endfunc 
autocmd BufNewFile * normal G
