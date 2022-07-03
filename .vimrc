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

" 最終行を追加する設定
set eol
set nofixendofline

" カッコ・タグの対応
set matchtime=1       " 括弧の対を見つけるミリ秒数
set matchpairs& matchpairs+=<:>,(:),{:},[:],  " マッチさせるかっこの設定
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

" BASE SETTING
set backspace=start,eol,indent "backspaceの設定"
set whichwrap=b,s,[,],,~ "カーソルキーの設定"
set wildmenu wildmode=list:full"補完の設定"

" insert mode to ESCを早くする
set ttimeoutlen=5

" spellcheck
set spell
set spelllang=en,cjk

" 表示関係
filetype plugin indent on

set re=0
set nolist nowrap colorcolumn=120
set linebreak
set nrformats-=octal

" insert modeの時に四角のカーソルにする
let &t_SI .= "\e[5 q"
let &t_EI .= "\e[1 q"

set hidden history=50 virtualedit=block

"ステータスラインの表示"
" set laststatus=2
" set statusline=%F%r%h%=
set tabstop=2 softtabstop=2 autoindent smartindent expandtab shiftwidth=2

set wildmenu
set wildmode=longest,list,full

set autochdir

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
set belloff=all
set vb t_vb=
set noerrorbells
set novisualbell

" Display Settings
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

set display=lastline  " 長い行も一行で収まるように
set showmatch         " 括弧の対応をハイライト
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set relativenumber
set ruler
set wrap              " 画面幅で折り返す
"set list              " 不可視文字表示
"set listchars=tab:>  " 不可視文字の表示方法
set title           " タイトル書き換えない

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



" ============================
"    Plugins
" ============================

let mapleader = "\<Space>"



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
" - Avoid using standard Vim directory names like 'plugin'
" === :PlugInstall ===

call plug#begin('~/.vim/plugged')

	Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}
	Plug 'tpope/vim-commentary'  " vim comment out by gcc

	Plug 'iamcco/mathjax-support-for-mkdp'
	" Markdown with :PreviewMarkdown
	Plug 'skanehira/preview-markdown.vim'

	" LSP
	" https://tech.fusic.co.jp/posts/2020-07-01-vim-lsp-settings/
	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'

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
	"" fzf.vim
	" Ctrl+pでファイル検索を開く
	" git管理されていれば:GFiles、そうでなければ:Filesを実行する
	fun! FzfOmniFiles()
		let is_git = system('git status')
		if v:shell_error
			:Files
		else
			:GFiles
		endif
	endfun
	nnoremap <C-p> :call FzfOmniFiles()<CR>

	" Ctrl+gで文字列検索を開く
	" fernなどでファイルを開いた時にも.gitから検索してくれる
	command! -bang -nargs=* Rg
				\ call fzf#vim#grep(
				\	"rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
				\ {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0
				\ )

	nnoremap <C-g> :Rg<CR>
	" frでカーソル位置の単語をファイル検索する
	nnoremap fr vawy:Rg <C-R>"<CR>
	" frで選択した単語をファイル検索する
	xnoremap fr y:Rg <C-R>"<CR>

	" fbでバッファ検索を開く
	nnoremap fb :Buffers<CR>
	" fpでバッファの中で1つ前に開いたファイルを開く
	nnoremap fp :Buffers<CR><CR>
	" flで開いているファイルの文字列検索を開く
	nnoremap fl :BLines<CR>
	" fmでマーク検索を開く
	nnoremap fm :Marks<CR>
	" fhでファイル閲覧履歴検索を開く
	nnoremap fh :History<CR>
	" fcでコミット履歴検索を開く
	nnoremap fc :Commits<CR>

	Plug 'gorodinskiy/vim-coloresque'
	Plug 'djoshea/vim-autoread'
	Plug 'ParamagicDev/vim-medic_chalk'
	Plug 'atahabaki/archman-vim'

	" 同期しながらsyntax checkできるが
	Plug 'dense-analysis/ale'
	" dense-analysis/ale
	let g:ale_set_highlights = 0
	let g:ale_linters = {'python': ['flake8']}
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],
				\   'python': ['black'],
				\ }
	let g:ale_fix_on_save = 1

	Plug 'ntpeters/vim-better-whitespace'

	" vim for latex
	Plug 'lervag/vimtex'
	let g:tex_flavor='latex'

	" molokai
	" Plug 'tomasr/molokai'
	Plug 'tomasiser/vim-code-dark'
	let g:airline_theme = 'codedark'

	" vim-airline
	" setting for statusbar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	" let g:airline#extensions#tabline#enabled = 1
	" ステータスラインに表示する項目を変更する
	" let g:airline#extensions#default#layout = [
	" 			\ [ 'a', 'b', 'c' ],
	" 			\ ['z']
	" 			\ ]
	" let g:airline_section_c = '%t %M'
	" let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
	" 変更がなければdiffの行数を表示しない
	" let g:airline#extensions#hunks#non_zero_only = 1

	" タブラインの表示を変更する
	" let g:airline#extensions#tabline#fnamemod = ':t'
	" let g:airline#extensions#tabline#show_buffers = 1
	" let g:airline#extensions#tabline#show_splits = 0
	" let g:airline#extensions#tabline#show_tabs = 1
	" let g:airline#extensions#tabline#show_tab_nr = 0
	" let g:airline#extensions#tabline#show_tab_type = 1
	" let g:airline#extensions#tabline#show_close_button = 0

	Plug 'bronson/vim-trailing-whitespace'

	" file tree
	Plug 'lambdalisue/fern.vim'
	" Ctrl+nでファイルツリーを表示/非表示する
	nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
	" file treeにgitの差分を表示する
	Plug 'lambdalisue/fern-git-status.vim'
	" fontの追加
	Plug 'lambdalisue/nerdfont.vim'
	Plug 'lambdalisue/fern-renderer-nerdfont.vim'
	let g:fern#renderer = 'nerdfont'
	" file treeのiconに色を付ける
	Plug 'lambdalisue/glyph-palette.vim'
	" アイコンに色をつける
	augroup my-glyph-palette
		autocmd! *
		autocmd FileType fern call glyph_palette#apply()
		autocmd FileType nerdtree,startify call glyph_palette#apply()
	augroup END

	" カラースキームを調べる
	Plug 'guns/xterm-color-table.vim'

	" Python
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'nvie/vim-flake8'
	Plug 'hynek/vim-python-pep8-indent'
	Plug 'Townk/vim-autoclose'

	Plug 'prettier/vim-prettier', {
				\ 'do': 'yarn install',
				\ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact'] }


  " git差分を左側に表示する
	Plug 'airblade/vim-gitgutter'
	"" git操作
	" g]で前の変更箇所へ移動する
	nnoremap g[ :GitGutterPrevHunk<CR>
	" g[で次の変更箇所へ移動する
	nnoremap g] :GitGutterNextHunk<CR>
	" ghでdiffをハイライトする
	nnoremap gh :GitGutterLineHighlightsToggle<CR>
	" gpでカーソル行のdiffを表示する
	nnoremap gp :GitGutterPreviewHunk<CR>
	" 記号の色を変更する
	highlight GitGutterAdd ctermfg=green
	highlight GitGutterChange ctermfg=blue
	highlight GitGutterDelete ctermfg=red
	"" 反映時間を短くする(デフォルトは4000ms)
	set updatetime=250

	Plug 'sheerun/vim-polyglot'

	" Terraform
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'

	Plug 'hashivim/vim-terraform' , { 'for': 'terraform'}
	if executable('terraform-lsp')
		au User lsp_setup call lsp#register_server({
					\ 'name': 'terraform-lsp',
					\ 'cmd': {server_info->['terraform-lsp']},
					\ 'whitelist': ['terraform','tf'],
					\ })
	endif
call plug#end()

" vim-prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0


" Python用. 構文エラーチェックにpep8とpyflakesを使用
" 保存時に自動でチェック
let g:PyFlakeOnWrite=1
let g:PyFlakeCheckers='pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10

" カラースキーム編集用
" ハイライトグループを知るコマンド:SyntaxInfoを実装
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
" colorscheme molokai
colorscheme codedark
" colorscheme panic

" syntax
syntax enable " 構文に色を付ける
syntax on

set cursorline "カーソル下の線
"ハイライトの設定"
highlight Normal ctermbg=black ctermfg=grey
" highlight CursorLine term=none cterm=none ctermfg=black ctermbg=gray
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=cyan
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

" save
" Ctrl-s で保存
nnoremap <C-s> :w<CR>

" ウィンドウ関連
set splitbelow splitright

" Split window
nmap ss :split .<Return><C-w>w
nmap sv :vsplit .<Return><C-w>w

" close window
nmap sq :wq!<Return>

" Move window in normal mode
nnoremap <Leader>h <C-w>h
nnoremap <Leader>k <C-w>k
nnoremap <Leader>j <C-w>j
nnoremap <Leader>l <C-w>l

" Switch tab
nmap th :tabprev<Return>
nmap <Tab> :tabnext<Return>
nmap tl :tabnext<Return>
" tabnew
nmap tn :tabnew .<Return>
nmap te :tabe .<Return>

" change `redo` command with shift + u
nmap <S-u> <C-r>

" delete line with shift + x
nmap <S-x> <S-v>x

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

" 開いているファイルのdiffを確認
nnoremap <C-d> :!git difftool %:p<CR>

" 'gcc'で一括コメントアウト
autocmd FileType apache setlocal commentstring=#\ %s
autocmd FileType vim setlocal foldmethod=marker

"===============================

" Local Configuration
" call SourceSafe('~/.vimrc.local')

"===============================
