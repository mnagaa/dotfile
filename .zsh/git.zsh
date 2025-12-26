# ==========================================
# Git 関連設定
# ==========================================

# git-promptの読み込み
if [[ -f ~/.zsh/git-prompt.sh ]]; then
  source ~/.zsh/git-prompt.sh
fi

autoload predict-on

# git-completionの読み込み
if [[ -d ~/.zsh ]]; then
  fpath=(~/.zsh $fpath)
fi

if [[ -f ~/.zsh/git-completion.bash ]]; then
  zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fi
# autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM=auto

