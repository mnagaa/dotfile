"==============================================================
"          Key Mappings Configuration
"==============================================================

" 矢印キーを無効化
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" save
" Ctrl-s で保存
nnoremap <C-s> :w<CR>

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
" execute current python file
nnoremap <Leader>eg :vert term go run %<CR>

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

