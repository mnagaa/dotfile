
#======================================
# setting path
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$HOME/.cargo/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH=$HOME/.nodebrew/current/bin:$PATH

# docker with lima
# https://zenn.dev/matsukaz/articles/31bc31ff1c54b4
export DOCKER_HOST=unix://$HOME/.lima/lima/sock/docker.sock

# python setup
export PYTHONPATH="$PWD:$PYTHONPATH"

# ==========================================
# 1) .zshenv
# 2) .zprofile
# 3) .zshrc  *** this file
# 4) .zlogin
#
# $ zcompile ~/.zshrc
# でコンパイルしておくと読み込むときに時間がかからなくなるので
# scriptが長くなったときに実行する
# ==========================================
# zplugが無ければインストール

if [[ ! -d $HOME/.zplug ]];then
  git clone https://github.com/zplug/zplug $HOME/dotfile/.zplug
  ln -s ~/dotfile/.zplug ~/.zplug
fi
# $ zplug install
# zplug
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# theme: https://github.com/unixorn/awesome-zsh-plugins#themes
# theme (https://github.com/sindresorhus/pure#zplug)

zplug "mafredri/zsh-async"

# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# history関係
zplug "zsh-users/zsh-history-substring-search"
# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    # if read -q; then
        echo; zplug install
    # fi
fi
# Then, source plugins and add commands to $PATH
zplug load

if [[ ! -d $HOME/dotfile/.fzf ]];then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/dotfile/.fzf
  ln -s ~/dotfile/.fzf ~/.fzf
  ~/.fzf/install
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
# ===================================
# Setting for Plugin
# ===================================
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-completions)

autoload predict-on
# predict-on
autoload -U compinit && compinit -u

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# share history when opening multi-prompt
setopt share_history
# 重複するコマンドのhistory削除
setopt hist_ignore_all_dups
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# cdなしでディレクトリ移動
setopt auto_cd
# ビープ音の停止
setopt no_beep
# ビープ音の停止(補完時)
setopt nolistbeep
# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd
# 文字コードの指定
export LANG=ja_JP.UTF-8
# 色を使用出来るようにする
autoload -Uz colors
colors


# git-promptの読み込み
source ~/.zsh/git-prompt.sh

# git-completionの読み込み
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# プロンプトの表示設定(好きなようにカスタマイズ可)
setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f
\$ '

alias ls='ls -G'
alias ll='ls -alF'

alias g='git'
alias ga='git add'
alias gd='git diff'
alias gp='git push'
alias gb='git branch'
alias gsw='git switch'
alias gst='git status'
alias gco='git checkout'
alias gf='git fetch'
alias gc='git commit'
