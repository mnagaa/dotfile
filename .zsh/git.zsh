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

# compinitの遅延読み込み（高速化）
# 補完システムの初期化を遅延させて起動時間を短縮
autoload -Uz compinit

# 補完キャッシュの設定（高速化）
# .zcompdumpファイルが24時間以内に更新されていればスキップ
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C  # チェックをスキップして高速化
fi

# 補完システムの最適化設定
# 補完候補をグループ化して表示
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
# 補完候補をキャッシュ（高速化）
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completion"
# 補完候補の表示を高速化
zstyle ':completion:*' menu select=2
# 大文字小文字を区別しない補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# 補完候補の色付け
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 補完候補の並び順を最適化（最近使用したものから）
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
# 補完候補の表示を高速化（詳細情報を非表示）
zstyle ':completion:*' verbose no

# プロンプトのオプション表示設定
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM=auto

