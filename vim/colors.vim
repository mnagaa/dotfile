"==============================================================
"          Colors and Syntax Configuration
"==============================================================

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

set t_Co=256

" syntax
syntax enable " 構文に色を付ける
syntax on

" カラースキームは plugins.vim の最後（plug#end()の後）で設定される

set cursorline "カーソル下の線
"ハイライトの設定"
highlight Normal ctermbg=black ctermfg=grey
" highlight CursorLine term=none cterm=none ctermfg=black ctermbg=gray
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=cyan
highlight Comment ctermfg=lightyellow

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

