" =======================
" .vimrc
" use macvim in my mac
" > brew install macvim
"
" add below
" alias vi="mvim -v"
"
" > mvim --version
" > vim --version | grep lua
" =======================

" if mac ... Darwin
let OSTYPE = system('uname')

if OSTYPE == "Darwin\n"
    " mac 向けの設定

elseif OSTYPE == "Linux\n"
    " Linux 向けの設定

endif

"==============================================================
"          Initial Configuration
"==============================================================

if has('unix')
  let $LANG = 'C'
else
  let $LANG = 'en'
endif
execute 'language ' $LANG
execute 'set langmenu='.$LANG

" Encode Settings
set encoding=utf-8 fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,sjis,latin1 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決
scriptencoding utf-8


"----------------------------------------------------------
"" カッコ・タグの対応
"----------------------------------------------------------
set matchtime=3
set matchpairs& matchpairs+=<:>
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する


"マウスの有効化"
if has('mouse')
	set mouse=a
	if has('mouse_sgr')
		set ttymouse=sgr
	elseif v:version > 703 || v:version is 703 && has('patch632')
		set ttymouse=sgr else
		set ttymouse=xterm2
	endif
endif

" The setting for NERDTree
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


"==============================================================
"         BASE SETTING
"==============================================================
set backspace=start,eol,indent "backspaceの設定"
set title
set whichwrap=b,s,[,],,~ "カーソルキーの設定"
set wildmenu wildmode=list:full"補完の設定"

" insert mode to ESCを早くする
set ttimeoutlen=5

" spellcheck
" set spell
set spelllang=en,cjk

"----------------------------------------------------------
" 表示関係
"----------------------------------------------------------
filetype plugin indent on

set nolist wrap colorcolumn=80
set linebreak
" set guicursor=n-v-c:block-Cursor
set nrformats-=octal

" insert modeの時に四角のカーソルにする
let &t_SI .= "\e[5 q"
let &t_EI .= "\e[1 q"

set hidden history=50 virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set number showmatch showcmd ruler

"ステータスラインの表示"
set laststatus=2
set statusline=%F%r%h%=

set background=dark
set tabstop=4 softtabstop=4 autoindent smartindent expandtab shiftwidth=4

set wildmenu
set wildmode=longest,list,full

" ====================
" 検索関連
set wrapscan   " 最後まで検索したら先頭へ戻る
"set nowrapscan " 最後まで検索しても先頭に戻らない
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" <C-n>の時に自分のファイルだけを検索する
setlocal complete=.,w,b,u,t
set complete-=i

" ウィンドウ関連
set splitbelow
set splitright

" ファイル関連
"set nobackup   " バックアップ取らない
set autoread   " 他で書き換えられたら自動で読み直す
set noswapfile " スワップファイル作らない
set hidden     " 編集中でも他のファイルを開けるようにする
" set backup
" set backupdir     =$HOME/.vim/backups/
" set backupext     =-vimbackup
" set backupskip    =
set directory     =$HOME/.vim/swap/
set updatecount   =100
set undofile
set undodir       =$HOME/.vim/undo/
set nomodeline

" OSのクリップボードを使う
" +レジスタ：Ubuntuの[Ctrl-v]で貼り付けられるもの unnamedplus
" *レジスタ：マウス中クリックで貼り付けられるもの unnamed
if has('nvim') || (((exists('$DISPLAY') && executable('pbcopy'))
      \   || (exists('$DISPLAY') && executable('xclip'))
      \   || (exists('$DISPLAY') && executable('xsel')))
      \   && has('clipboard')
      \ )
  set clipboard&
  set clipboard^=unnamedplus,unnamed
endif

" OS のクリップボードと共有できることを確認済み
set clipboard+=autoselect
set clipboard+=unnamed

" paste
set paste

" ビープ音除去
set vb t_vb=
set noerrorbells
set novisualbell


"==============================================================
"         Display Settings
"==============================================================

" ColorScheme
if has('syntax') && !exists('g:syntax_on')
  syntax enable " シンタックスカラーリングオン
endif
set t_Co=256
set background=dark

" true color support
let colorterm=$COLORTERM
if colorterm=='truecolor' || colorterm=='24bit' || colorterm==''
  if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
endif

" colorscheme pluginconfig -> colorscheme
set nocursorline

set display=lastline  " 長い行も一行で収まるように
set showmatch         " 括弧の対応をハイライト
set matchtime=1       " 括弧の対を見つけるミリ秒数
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set relativenumber
set wrap              " 画面幅で折り返す
"set list              " 不可視文字表示
"set listchars=tab:>  " 不可視文字の表示方法
set notitle           " タイトル書き換えない
if !&scrolloff
  set scrolloff=5
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set pumheight=10      " 補完候補の表示数

" 折りたたみ設定
"set foldmethod=marker
set foldmethod=manual
set foldlevel=1
set foldlevelstart=99
set foldcolumn=0

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction


if exists('&cursorlineopt')
  set cursorlineopt=number
endif



" ============================
"    Plugins
" ============================

if has('vim_starting')
    " setting for vim-plug
    let s:plugin_manager_dir='~/.vim/plugged/vim-plug'
    execute 'set runtimepath+=' . s:plugin_manager_dir
    if !isdirectory(expand(s:plugin_manager_dir))
        call system('mkdir -p ' . s:plugin_manager_dir)
        call system('git clone --depth 1 https://github.com/junegunn/vim-plug.git '
                \ . s:plugin_manager_dir . '/autoload')
    end
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
" === :PlugInstall ===
call plug#begin('~/.vim/plugged')

    Plug 'junegunn/vim-plug',
    \ {'dir': '~/.vim/plugged/vim-plug/autoload'}

	Plug 'tpope/vim-commentary'  " vim comment out: gcc

    " markdown preview for vim
    " usage:
    "   MarkdownPreview
    "     Open preview window in markdown buffer
    "   MarkdownPreviewStop
    "     Close the preview window and server
    Plug 'iamcco/mathjax-support-for-mkdp'
    Plug 'iamcco/markdown-preview.vim'
    " LSP
    " https://tech.fusic.co.jp/posts/2020-07-01-vim-lsp-settings/
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'

    " too slow
    " Plug 'vwxyutarooo/nerdtree-devicons-syntax'
    " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
    " let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
    " let g:NERDTreeFileExtensionHighlightFullName = 1
    " let g:NERDTreeExactMatchHighlightFullName = 1
    " let g:NERDTreePatternMatchHighlightFullName = 1

    " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
    Plug 'junegunn/vim-easy-align'

    " Any valid git URL is allowed
    Plug 'junegunn/vim-github-dashboard'

    " Multiple Plug commands can be written in a single line using | separators
    " Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " On-demand loading
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

    "" Using a non-default branch
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

    " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
    " Plug 'fatih/vim-go', { 'tag': '*' }
    " Plugin options
    " Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

    " Plugin outside ~/.vim/plugged with post-update hook
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
	" like Spacemacs
	let mapleader = "\<Space>"
	let g:fzf_command_prefix = 'Fzf'

	nnoremap <Leader>b :FzfBuffers<CR>
	nnoremap <Leader>x :FzfCommands<CR>
	nnoremap <Leader>f :FzfGFiles<CR>
	nnoremap <Leader>a :FzfAg<CR>
	nnoremap <Leader>k :bd<CR>
	command! FZFMru call fzf#run({
				\  'source':  v:oldfiles,
				\  'sink':    'e',
				\  'options': '-m -x +s',
				\  'down':    '40%'})
	nnoremap <Leader>r :FZFMru<CR>

    " Unmanaged plugin (manually installed and updated)
    Plug '~/my-prototype-plugin'

    Plug 'gorodinskiy/vim-coloresque'
    Plug 'djoshea/vim-autoread'
    Plug 'ParamagicDev/vim-medic_chalk'
    Plug 'atahabaki/archman-vim'

    " 同期しながらsyntax checkできるが
    Plug 'dense-analysis/ale'

    " vim for latex
    Plug 'lervag/vimtex'
    let g:tex_flavor='latex'

    " molokai
    Plug 'tomasr/molokai'
    Plug 'bronson/vim-trailing-whitespace'
    " カラースキームを調べる
    Plug 'guns/xterm-color-table.vim'
    " 構文エラーチェック
    Plug 'scrooloose/syntastic'
    " "プロジェクトに入っているESLintを読み込む
    Plug 'pmsorhaindo/syntastic-local-eslint.vim'

    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'nvie/vim-flake8'

    Plug 'hynek/vim-python-pep8-indent'
    Plug 'Townk/vim-autoclose'
    " NERDTree
    " Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    " Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
    " Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
call plug#end()


"-----------
"" Syntastic
"-----------
" Javascript用. 構文エラーチェックにESLintを使用
let g:syntastic_javascript_checkers=['eslint']

" Python用. 構文エラーチェックにpep8とpyflakesを使用
" 保存時に自動でチェック
let g:PyFlakeOnWrite=1
let g:PyFlakeCheckers='pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10

let g:syntastic_python_checkers=['pylint', 'pep8']

let g:syntastic_html_checkers=['tidy']
let g:syntastic_css_checkers=['csslint']

let g:syntastic_tex_checkers=['lacheck']

" Javascript, python以外は構文エラーチェックをしない
let g:syntastic_mode_map = { 'mode': 'passive',
			\ 'active_filetypes': ['javascript', 'html', 'css'],
			\ 'passive_filetypes': [] }

"----------------------------------------------------------
"" カラースキーム編集用
"----------------------------------------------------------
"" ハイライトグループを知るコマンド:SyntaxInfoを実装
function! s:get_syn_id(transparent)
	let synid = synID(line("."), col("."), 1)
	if a:transparent
		return synIDtrans(synid)
	else
		return synid
	endif
endfunction
function! s:get_syn_attr(synid)
	let name = synIDattr(a:synid, "name")
	let ctermfg = synIDattr(a:synid, "fg", "cterm")
	let ctermbg = synIDattr(a:synid, "bg", "cterm")
	let guifg = synIDattr(a:synid, "fg", "gui")
	let guibg = synIDattr(a:synid, "bg", "gui")
	return {
				\ "name": name,
				\ "ctermfg": ctermfg,
				\ "ctermbg": ctermbg,
				\ "guifg": guifg,
				\ "guibg": guibg}
endfunction

function! s:get_syn_info()
	let baseSyn = s:get_syn_attr(s:get_syn_id(0))
	echo "name: " . baseSyn.name .
				\ " ctermfg: " . baseSyn.ctermfg .
				\ " ctermbg: " . baseSyn.ctermbg .
				\ " guifg: " . baseSyn.guifg .
				\ " guibg: " . baseSyn.guibg
	let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
	echo "link to"
	echo "name: " . linkedSyn.name .
				\ " ctermfg: " . linkedSyn.ctermfg .
				\ " ctermbg: " . linkedSyn.ctermbg .
				\ " guifg: " . linkedSyn.guifg .
				\ " guibg: " . linkedSyn.guibg
endfunction

command! SyntaxInfo call s:get_syn_info()


set t_Co=256
" colorscheme medic_chalk
" colorscheme simpleblack
colorscheme molokai
" colorscheme panic
syntax enable " 構文に色を付ける

if has("syntax")
  syntax on
endif

"syntax"
set cursorline "カーソル下の線

"ハイライトの設定"
highlight Normal ctermbg=black ctermfg=grey
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=grey
" highlight CursorLine term=none cterm=none ctermfg=black ctermbg=grey
highlight Comment ctermfg=lightyellow


" Plugin Settings
if &term =~ "xterm"
	let &t_SI .= "\e[?2004h"
	let &t_EI .= "\e[?2004l"
	let &pastetoggle = "\e[201~"
		function XTermPasteBegin(ret)
		set paste
		return a:ret
	endfunction
	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" ===========================
" custum setting
" ===========================
" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
let g:plug_window = 'noautocmd vertical topleft new'
let NERDTreeShowHidden=1

" keymapping
" keymapping
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" nmap
"   this sometimes happens recursive mapping.
"   Recomending the below command.
" nnoremap
"   e.g.,
"   nnoremap
"
" マップコマンドに関する情報
" :h mapping
"
" マップコマンドの対応の情報
" :h map-modes
"

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" close window
nmap sq :wq!<Return>

" Move window in normal mode
nnoremap mh <C-w>h
nnoremap mk <C-w>k
nnoremap mj <C-w>j
nnoremap ml <C-w>l

" Switch tab
nmap th :tabprev<Return>
nmap tl :tabnext<Return>
" tabnew
nmap tn :tabnew .<Return>

" change `redo` command
nnoremap U <C-r>

" NERDtree space + n でNERDtreeを開くことができる
nnoremap <Space>n :NERDTreeToggle<CR>

" Esc 2回でハイライトの切替
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>

" 折り返しがあったときにも一行ずつ移動する
nnoremap j gj
nnoremap k gk

" 行頭への移動
noremap <S-h> 0
noremap <S-l> $

" Yでキャレット行末までヤンクする
nnoremap Y y$

" 'gcc'で一括コメントアウト
autocmd FileType apache setlocal commentstring=#\ %s
autocmd FileType vim setlocal foldmethod=marker




" When I run nerdtree, it show "readonly".
" I add this autocmd here.
" autocmd FileType nerdtree setlocal noreadonly


"===============================

" Local Configuration
" call SourceSafe('~/.vimrc.local')

"===============================
