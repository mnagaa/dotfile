"==============================================================
"          Plugins Configuration
"==============================================================

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
	Plug 'fatih/vim-go'
	" Plugin options

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

	Plug 'chrisbra/csv.vim'
	if exists("did_load_csvfiletype")
		finish
	endif
	let did_load_csvfiletype=1
	autocmd BufNewFile,BufRead *.CSV let b:csv_headerline=0
	autocmd BufNewFile,BufRead *.CSV set filetype=csv

	autocmd BufNewFile,BufRead *.SSV let g:csv_delim=' '
	autocmd BufNewFile,BufRead *.SSV let b:csv_headerline=0
	autocmd BufNewFile,BufRead *.SSV set filetype=csv

	autocmd BufNewFile,BufRead *.ssv let g:csv_delim=' '
	autocmd BufNewFile,BufRead *.ssv let b:csv_headerline=0
	autocmd BufNewFile,BufRead *.ssv set filetype=csv

	autocmd BufNewFile,BufRead *.TAG let g:csv_delim=' '
	autocmd BufNewFile,BufRead *.TAG set filetype=csv

	autocmd BufNewFile,BufRead *.TSV let g:csv_no_conceal=1
	autocmd BufNewFile,BufRead *.TSV set tabstop=20
	autocmd BufNewFile,BufRead *.TSV set filetype=csv

	autocmd BufNewFile,BufRead *.tsv let g:csv_no_conceal=1
	autocmd BufNewFile,BufRead *.tsv set tabstop=20
	autocmd BufNewFile,BufRead *.tsv set filetype=csv

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
	" Plug 'dense-analysis/ale'

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

	" LSP
	" https://tech.fusic.co.jp/posts/2020-07-01-vim-lsp-settings/
	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'
	let g:lsp_async_completion = 1
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	if executable('golsp')
		augroup LspGo
			au!
			autocmd User lsp_setup call lsp#register_server({
						\ 'name': 'go-lang',
						\ 'cmd': {server_info->['golsp', '-mode', 'stdio']},
						\ 'whitelist': ['go'],
						\ })
			autocmd FileType go setlocal omnifunc=lsp#complete
		augroup END
	endif
	" Terraform
	Plug 'hashivim/vim-terraform' , {'for': 'terraform'}
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

" BufExplorer設定
let g:bufExplorerShowDirectories=0
let g:bufExplorerShowUnlisted=0
let g:bufExplorerSortBy='fullpath'

" カラースキームを設定（プラグイン読み込み後）
try
	colorscheme codedark
catch /^Vim\%((\a\+)\)\=:E185/
	" プラグインがまだインストールされていない場合はスキップ
endtry

