"==============================================================
"          Options Configuration
"==============================================================

" Language Settings
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

" ウィンドウ関連
set splitbelow splitright
