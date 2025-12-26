"==============================================================
"          Vim Configuration
"          Main configuration file
"==============================================================

" 設定ファイルのディレクトリパスを取得（シンボリックリンクを解決）
let s:config_dir = fnamemodify(resolve(expand('<sfile>')), ':p:h') . '/vim'

" 各設定ファイルを読み込む
execute 'source ' . s:config_dir . '/options.vim'
execute 'source ' . s:config_dir . '/plugins.vim'
execute 'source ' . s:config_dir . '/colors.vim'
execute 'source ' . s:config_dir . '/keymaps.vim'

"===============================
" Local Configuration
" call SourceSafe('~/.vimrc.local')
"===============================
