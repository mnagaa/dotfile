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
" 読み込み時の文字コードの自動判別. 左側が優先される
set fileencodings=ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,sjis,latin1
" 改行コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac
" □や○文字が崩れる問題を解決
set ambiwidth=double
scriptencoding utf-8

" 最終行を追加する設定
set eol nofixendofline

" カッコ・タグの対応
" 括弧の対を見つけるミリ秒数
set matchtime=1
" マッチさせるかっこの設定
set matchpairs& matchpairs+=<:>,(:),{:},[:],
" Vimの「%」を拡張する
source $VIMRUNTIME/macros/matchit.vim

" BASE SETTING
set backspace=start,eol,indent "backspaceの設定"
set whichwrap=b,s,[,],,~ "カーソルキーの設定"
set wildmenu wildmode=list:full"補完の設定"

" spellcheck
set spelllang=en,cjk
set spell

" 表示関係
filetype plugin indent on

set re=0
set nolist nowrap colorcolumn=120
set linebreak
set nrformats-=octal

set hidden history=50 virtualedit=block

"ステータスラインの表示"
set laststatus=2
set statusline=%F
set tabstop=2 softtabstop=2 autoindent smartindent expandtab shiftwidth=2

set wildmenu
set wildmode=longest,list,full

" set autochdir

" 検索関連
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" <C-n>の時に自分のファイルだけを検索する
setlocal complete=.,w,b,u,t
set complete-=i

" ファイル関連
set nobackup   " バックアップ取らない
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
syntax enable " シンタックスカラーリングオン
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

set showmatch         " 括弧の対応をハイライト
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
" set relativenumber
set ruler
"set list              " 不可視文字表示
"set listchars=tab:>  " 不可視文字の表示方法
set title           " タイトル書き換えない

set pumheight=20      " 補完候補の表示数

" 折りたたみ設定
"set foldmethod=marker
set foldmethod=manual
set foldlevel=1
set foldlevelstart=99
set foldcolumn=0


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
	Plug 'psf/black', { 'branch': 'stable' }
	" 同期しながらsyntax checkできるが
	Plug 'dense-analysis/ale'

	" dense-analysis/ale
	let g:ale_set_highlights = 0
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	let g:ale_fix_on_save = 1
	let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
	let g:ale_fixers.python = ['autopep8', 'black', 'isort']
	let g:ale_linters = {}
	let g:ale_linters.python = ['flake8', 'black']


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
	" Plug 'vim-airline/vim-airline'
	" Plug 'vim-airline/vim-airline-themes'
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


	" BufExplorer
	" * <CR> ... 選択されたバッファをアクティブに
	" * f ... 選択されたバッファを水平分割
	" * v ... 選択されたバッファを垂直分割
	" * t ... 選択されたバッファを別タブページに
	" * d ... 選択されたバッファを削除
	" * q ... BufExplorerを終了
	Plug 'jlanzarotta/bufexplorer'

	""" Fean: file tree
	" Ctrl+nで" Show hidden files
	Plug 'lambdalisue/fern.vim'
	let g:fern#default_hidden=1 " ファイルツリーを表示/非表示する
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

" vimで開いているファイルのディレクトリに移動
:set autochdir

set t_Co=256
colorscheme codedark

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
" if &term =~ "xterm"
" 	let &t_SI .= "\e[?2004h"
" 	let &t_EI .= "\e[?2004l"
" 	let &pastetoggle = "\e[201~"
" 	function XTermPasteBegin(ret)
" 		set paste
" 		return a:ret
" 	endfunction
" 	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
" endif


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
nmap ss :split .<CR>
nmap sv :vsplit .<CR>

" close window
nmap sq :wq!<Return>

" terminal
nnoremap <Leader>v :vertical terminal<CR>

" lazygit
nnoremap <Leader>g :vert term ++close lazygit<CR>

" execute current python file
nnoremap <Leader>ep :vert term python %<CR>

" REPL: python
nnoremap <Leader>rp :vert term ++close ipython<CR>

" move windows
nnoremap <Leader>h <C-w>h
nnoremap <Leader>k <C-w>k
nnoremap <Leader>j <C-w>j
nnoremap <Leader>l <C-w>l
nnoremap <C-w><C-h> <C-w>h
nnoremap <C-w><C-k> <C-w>k
nnoremap <C-w><C-j> <C-w>j
nnoremap <C-w><C-l> <C-w>l

nnoremap <Leader><Left> <C-w>h
nnoremap <Leader><Right> <C-w>l
nnoremap <Leader><Up> <C-w>k
nnoremap <Leader><Down> <C-w>j

" spell
" [s or s] ... jump
" z= ... 正しいspellの候補
nnoremap <Leader>s :set invspell<CR>

" Netrw
nnoremap <Leader>e :Vexplore<CR>
" nnoremap <Leader>S :Sexplore<CR>
" nnoremap <Leader>V :Vexplore<CR>

" BufExplorer
" Leader bでバッファ表示
let g:bufExplorerShowDirectories=0
let g:bufExplorerShowUnlisted=0
let g:bufExplorerSortBy='fullpath'
nnoremap <Leader>b :BufExplorerHorizontalSplit<CR>

" jump
" * Ctrl-] ... トピックへジャンプ
" * Ctrl-o ... ジャンプ元に戻る
 nnoremap <expr> <C-]> execute('LspPeekDefinition') =~ "not supported" ? "\<C-]>" : ":LspDefinition<cr>"

" info
" * K ... カーソル上の単語のマニュアルを開く
" * :so $<CR> ... 現在のファイルを再ロード

" vimrcを開く
nnoremap <Leader>ev :vsplit ~/dotfile/.vimrc<CR>

" Switch tab
nmap th :tabprev<Return>
nmap <Tab> :tabnext<Return>
nmap tl :tabnext<Return>
" tabnew
nmap tn :tabnew .<Return>
nmap te :tabe .<Return>

nnoremap gh gT
nnoremap gl gt
" change `redo` command with shift + u
nmap <S-u> <C-r>

" delete line with shift + x
nmap <S-x> <S-v>x

" Esc 2回でハイライトの切替
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>

" 折り返しがあったときにも一行ずつ移動する
nnoremap j gj
nnoremap k gk

nnoremap <C-j> j 15
nnoremap <C-k> k 15

" 行頭への移動
noremap <S-h> 0
noremap <S-l> $

" Yでキャレット行末までヤンクする
nnoremap Y y$

" 'gcc'で一括コメントアウト
autocmd FileType apache setlocal commentstring=#\ %s
autocmd FileType vim setlocal foldmethod=marker

"===============================

" Local Configuration
" call SourceSafe('~/.vimrc.local')

"===============================
