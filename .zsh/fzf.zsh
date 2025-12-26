# ==========================================
# fzf (ファジーファインダー) 設定
# ==========================================

# fzfのインストールチェック（高速化のため、シンボリックリンクの存在も確認）
if [[ ! -d $HOME/.fzf ]] && [[ ! -L $HOME/.fzf ]]; then
  if [[ ! -d $HOME/dotfile/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/dotfile/.fzf
  fi
  [[ -d $HOME/dotfile/.fzf ]] && ln -s ~/dotfile/.fzf ~/.fzf
  [[ -f ~/.fzf/install ]] && ~/.fzf/install --no-update-rc --no-bash --no-fish
fi

# fzf設定ファイルの読み込み（存在する場合のみ）
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# fzfのデフォルト設定
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

